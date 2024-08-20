module "security_group" {
  source = "git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/security-group/?ref=tags/1.2.0"
  name   = "parksm-test-sg"
  ingress_rules = [
    {
      action     = "ACCEPT"
      port       = "80,443,8080"
      protocol   = "TCP"
      ipv4_cidrs = ["192.168.0.0/16", "10.0.0.0/8", "172.168.0.0/24"]
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

module "ssh_key" {
  source             = "git::https://github.com/SkylerPark/terraform-tencent-cvm-module.git//modules/key-pair/?ref=tags/1.0.5"
  name               = "parksmKey"
  create_private_key = true
}

data "tencentcloud_image" "rocky8" {
  os_name = "rocky"

  filter {
    name   = "image-type"
    values = ["SHARED_IMAGE"]
  }

  filter {
    name   = "image-name"
    values = ["iep-rocky8-v1"]
  }
}

locals {
  instances = {
    "01" = {
      instance_type = "SA2.MEDIUM2"
      is_lb         = true
    }
    "02" = {
      instance_type = "SA2.MEDIUM4"
      is_lb         = false
    }
  }
}

module "instance" {
  source            = "git::https://github.com/SkylerPark/terraform-tencent-cvm-module.git//modules/instance/?ref=tags/1.0.5"
  for_each          = local.instances
  name              = "parksm-test-${each.key}"
  image_id          = data.tencentcloud_image.rocky8.image_id
  key_id            = module.ssh_key.name
  system_disk_size  = 50
  system_disk_type  = "CLOUD_PREMIUM"
  eip_enabled       = true
  vpc_id            = module.vpc.id
  availability_zone = local.availability_zones[(index(keys(local.instances), each.key)) % length(local.availability_zones)]
  subnet_id         = module.public_subnet_group.ids[(index(keys(local.instances), each.key)) % length(module.public_subnet_group.ids)]
  security_groups   = [module.security_group.id]
  bandwidth_max_out = 100
  cbs_block_device = {
    swap = {
      storage_size = 10
      storage_type = "CLOUD_PREMIUM"
      encrypt      = true
    }
  }
}
