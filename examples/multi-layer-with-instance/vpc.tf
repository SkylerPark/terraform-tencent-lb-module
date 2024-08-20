locals {
  region              = "ap-seoul"
  public_subnet_count = 2
  availability_zones  = ["ap-seoul-1", "ap-seoul-2"]
  vpc_cidr            = "10.70.0.0/16"
}

module "vpc" {
  source = "git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/vpc/?ref=tags/1.2.0"
  name   = "parksm-test-vpc"
  ipv4_cidrs = [
    {
      cidr = local.vpc_cidr
    }
  ]
}

module "public_subnet_group" {
  source = "git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/subnet-group/?ref=tags/1.2.0"
  vpc_id = module.vpc.id
  subnets = {
    for idx in range(local.public_subnet_count) : format("parksm-test-public-subnet-0%s", (idx + 1)) => {
      availability_zone = local.availability_zones[idx % length(local.availability_zones)]
      ipv4_cidr         = cidrsubnet(local.vpc_cidr, 8, 10 + idx + 1)
    }
  }
}

module "public_route_table" {
  source  = "git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/route-table/?ref=tags/1.2.0"
  name    = "parksm-test-public-rt"
  vpc_id  = module.vpc.id
  subnets = module.public_subnet_group.ids

  ipv4_routes = []
}
