module "layer4_security_group" {
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

module "layer4_clb" {
  source = "../../modules/instance"
  name   = "parksm-lb"

  is_public = true
  vpc_id    = module.vpc.id

  security_groups   = [module.layer4_security_group.id]
  bandwidth_max_out = 2048

  layer4_listeners = [
    {
      port     = 80
      protocol = "TCP"
      health_check = {
        enabled             = true
        interval            = 2
        timeout             = 2
        healthy_threshold   = 3
        unhealthy_threshold = 3
        port                = 80
        type                = "TCP"
      }
      load_balancing_algorithm_type = "LEAST_CONN"
    }
  ]
}

module "parksm_attachment_v1" {
  source        = "../../modules/target-attachment"
  load_balancer = module.layer4_clb.id
  listener      = module.layer4_clb.layer4_listeners["80"].id
  targets = [
    for instance, value in local.instances : {
      instance_id = module.instance[instance].id
      port        = 80
      weight      = 100
    } if value.is_lb
  ]
}
