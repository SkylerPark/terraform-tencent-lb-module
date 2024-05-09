output "name" {
  description = "load balancer Name"
  value       = tencentcloud_clb_instance.this.clb_name
}

output "id" {
  description = "load balancer id"
  value       = tencentcloud_clb_instance.this.id
}

output "domain" {
  description = "load balancer DNS name."
  value       = tencentcloud_clb_instance.this.domain
}

output "ip_address_type" {
  description = "load balancer IP Type."
  value       = upper(tencentcloud_clb_instance.this.address_ip_version)
}

output "vpc_id" {
  description = "load balancer 가 생성된 VPC ID"
  value       = tencentcloud_clb_instance.this.vpc_id
}

output "subnet_id" {
  description = "load balancer 가 생성된 Subnet ID"
  value       = tencentcloud_clb_instance.this.subnet_id
}

output "bandwidth_max_out" {
  description = "load balancer bandwidth max out"
  value       = tencentcloud_clb_instance.this.internet_bandwidth_max_out
}

output "zone_id" {
  description = "load balancer zone"
  value = {
    master = tencentcloud_clb_instance.this.master_zone_id
    slave  = tencentcloud_clb_instance.this.slave_zone_id
  }
}

output "is_public" {
  description = "load balancer public 으로 할당중인지 여부"
  value       = var.is_public
}

output "listeners" {
  description = "load balancer listener 리스트"
  value       = module.listener
}
