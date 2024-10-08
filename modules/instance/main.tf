locals {
  is_public = {
    true  = "OPEN"
    false = "INTERNAL"
  }

  cross_zone_enabled = length(var.availability_zones) > 2

  sla_type = {
    STANDARD      = "clb.c2.medium"
    ADVANCED_1    = "clb.c3.small"
    ADVANCED_2    = "clb.c3.medium"
    SUPER_LARGE_1 = "clb.c4.small"
    SUPER_LARGE_2 = "clb.c4.medium"
    SUPER_LARGE_3 = "clb.c4.large"
    SUPER_LARGE_4 = "clb.c4.xlarge"
  }
}

module "access_log" {
  source     = "../lb-logging"
  count      = var.access_log.enabled ? 1 : 0
  period     = var.access_log.period
  topic_name = var.access_log.topic_name
}

resource "tencentcloud_clb_instance" "this" {
  project_id = var.project_id
  clb_name   = var.name

  network_type                 = local.is_public[var.is_public]
  vpc_id                       = var.vpc_id
  subnet_id                    = var.subnet_id
  load_balancer_pass_to_target = var.load_balancer_pass_to_target
  security_groups              = var.security_groups

  log_set_id   = var.access_log.enabled ? module.access_log.log_set_id : null
  log_topic_id = var.access_log.enabled ? module.access_log.log_topic_id : null

  delete_protect = var.delete_protect_enabled

  internet_bandwidth_max_out = var.is_public ? var.bandwidth_max_out : null
  bandwidth_package_id       = var.is_public ? var.bandwidth_package_id : null
  internet_charge_type       = var.is_public ? var.charge_type : null

  master_zone_id = local.cross_zone_enabled && var.is_public ? var.availability_zones[0] : null
  slave_zone_id  = local.cross_zone_enabled && var.is_public ? var.availability_zones[1] : null
  zone_id        = !local.cross_zone_enabled && var.is_public ? try(var.availability_zones[0], null) : null

  sla_type = var.lcu.enabled ? local.sla_type[var.lcu.type] : null

  tags = var.tags
}

module "layer7_listener" {
  source = "../layer7-listener"
  for_each = {
    for listener in var.layer7_listeners :
    listener.port => listener
  }

  load_balancer = tencentcloud_clb_instance.this.id
  name          = "${each.value.protocol}-${each.key}"
  port          = each.key
  protocol      = each.value.protocol

  rules = try(each.value.rules, {})

  tls = {
    certificate_mode = try(each.value.tls.certificate_mode, null)
    certificate      = try(each.value.tls.certificate, null)
    certificate_ca   = try(each.value.tls.certificate_ca, null)
    sni_enabled      = try(each.value.tls.sni_enabled, null)
  }
}

module "layer4_listener" {
  source = "../layer4-listener"
  for_each = {
    for listener in var.layer4_listeners :
    listener.port => listener
  }

  load_balancer = tencentcloud_clb_instance.this.id
  name          = "${each.value.protocol}-${each.key}"
  port          = each.key
  protocol      = each.value.protocol

  health_check                  = try(each.value.health_check, {})
  load_balancing_algorithm_type = each.value.load_balancing_algorithm_type
  session_expire_time           = try(each.value.session_expire_time, null)

  tls = {
    certificate_mode = try(each.value.tls.certificate_mode, null)
    certificate      = try(each.value.tls.certificate, null)
    certificate_ca   = try(each.value.tls.certificate_ca, null)
  }
}

###################################################
# ElasticIP
###################################################
resource "tencentcloud_eip" "this" {
  count                      = var.eip_enabled ? 1 : 0
  name                       = var.name
  internet_charge_type       = var.charge_type
  internet_max_bandwidth_out = var.bandwidth_max_out
  type                       = "EIP"

  tags = merge(var.tags, var.eip_tags)
}

resource "tencentcloud_eip_association" "this" {
  count       = var.eip_enabled ? 1 : 0
  eip_id      = tencentcloud_eip.this[count.index].id
  instance_id = tencentcloud_clb_instance.this.id
}
