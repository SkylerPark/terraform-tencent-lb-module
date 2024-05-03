locals {
  is_public = {
    true  = "OPEN"
    false = "INTERNAL"
  }
}

resource "tencentcloud_clb_instance" "this" {
  project_id = var.project_id
  clb_name   = var.name

  network_type    = local.is_public[var.is_public]
  vpc_id          = var.vpc_id
  subnet_id       = var.subnet_id
  security_groups = var.security_groups

  log_set_id   = var.access_log.enabled ? var.access_log.set_id : null
  log_topic_id = var.access_log.enabled ? var.access_log.topid_id : null

  delete_protect = var.delete_protect

  internet_bandwidth_max_out = var.bandwidth_max_out
  internet_charge_type       = var.charge_type

  tags = var.tags
}
