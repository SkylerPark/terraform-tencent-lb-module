module "clb_security_group" {
  source = "git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/security-group/?ref=tags/1.2.0"
  name   = "parksm-test-sg"
  ingress_rules = [
    {
      action     = "ACCEPT"
      port       = "80,443,8080"
      protocol   = "TCP"
      ipv4_cidrs = ["0.0.0.0"]
    }
  ]

  egress_rules = [
    {
      action     = "ACCEPT"
      port       = "ALL"
      protocol   = "ALL"
      ipv4_cidrs = ["0.0.0.0/0"]
    }
  ]
}

module "clb" {
  source = "../../modules/instance"
  name   = "parksm-lb"

  is_public = true
  vpc_id    = module.vpc.id

  security_groups   = [module.clb_security_group.id]
  bandwidth_max_out = 2048

  layer4_listeners = [
    {
      port     = 8080
      protocol = "TCP"
      health_check = {
        enabled             = true
        interval            = 2
        timeout             = 2
        healthy_threshold   = 3
        unhealthy_threshold = 3
        port                = 8080
        type                = "TCP"
      }
      load_balancing_algorithm_type = "LEAST_CONN"
    }
  ]

  layer7_listeners = [
    {
      port     = 80
      protocol = "HTTP"
      rules = [
        {
          domain      = "test.com"
          url         = "/"
          target_type = "NODE"
          health_check = {
            enabled             = true
            interval            = 3
            healthy_threshold   = 3
            unhealthy_threshold = 2
            matcher             = 2
            path                = "/"
            domain              = "localhost"
            method              = "GET"
            timeout             = 3
          }
          load_balancing_algorithm_type = "LEAST_CONN"
        },
        {
          domain      = "test1.com"
          url         = "/"
          target_type = "NODE"
          health_check = {
            enabled             = true
            interval            = 3
            healthy_threshold   = 3
            unhealthy_threshold = 2
            matcher             = 2
            path                = "/"
            domain              = "localhost"
            method              = "GET"
            timeout             = 3
          }
          load_balancing_algorithm_type = "LEAST_CONN"
        }
      ]
    }
  ]
}

module "layer4_attachment_8080" {
  source        = "../../modules/target-attachment"
  load_balancer = module.clb.id
  listener      = module.clb.layer4_listeners["8080"].id
  targets = [
    for instance, value in local.instances : {
      instance_id = module.instance[instance].id
      port        = 8080
      weight      = 100
    } if value.is_lb
  ]
}

module "layer7_attachment_80" {
  source        = "../../modules/target-attachment"
  load_balancer = module.clb.id
  listener      = module.clb.layer7_listeners["80"].id
  rule          = module.clb.layer7_listeners["80"].rules["test.com/"].id
  targets = [
    for instance, value in local.instances : {
      instance_id = module.instance[instance].id
      port        = 80
      weight      = 100
    } if value.is_lb
  ]
}
