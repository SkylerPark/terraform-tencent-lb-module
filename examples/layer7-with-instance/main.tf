module "layer7_security_group" {
  source = "git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/security-group/?ref=tags/1.2.0"
  name   = "parksm-test-sg"
  ingress_rules = [
    {
      action     = "ACCEPT"
      port       = "80,443"
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

module "layer7" {
  source = "../../modules/layer7-instance"
  name   = "parksm-lb"

  is_public = true
  vpc_id    = module.vpc.id

  security_groups   = [module.layer7_security_group.id]
  bandwidth_max_out = 2048

  listeners = [
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

module "parksm_attachment_v1" {
  source        = "../../modules/target-attachment"
  load_balancer = module.layer7.id
  listener      = module.layer7.listeners["80"].id
  rule          = module.layer7.listeners["80"].rules["test.com/"].id
  targets = [
    for instance, value in local.instances : {
      instance_id = module.instance[instance].id
      port        = 80
      weight      = 100
    } if value.is_lb
  ]
}
