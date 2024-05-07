resource "tencentcloud_clb_listener" "this" {
  clb_id = var.load_balancer

  listener_name = var.name
  port          = var.port
  protocol      = var.protocol

  certificate_ssl_mode = var.protocol == "HTTPS" ? var.tls.certificate_mode : null
  certificate_id       = var.protocol == "HTTPS" ? var.tls.certificate : null
  certificate_ca_id    = var.protocol == "HTTPS" && var.tls.certificate_mode == "MUTUAL" ? var.tls.certificate_ca : null
  sni_switch           = var.protocol == "HTTPS" ? var.tls.sni_enabled : null
}

resource "tencentcloud_clb_listener_rule" "this" {
  for_each = {
    for rule in var.rules :
    "${rule.domain}-${rule.url}" => rule
  }
  clb_id      = var.load_balancer
  listener_id = tencentcloud_clb_listener.this.listener_id

  domain = each.value.domain
  url    = each.value.url

  health_check_switch        = each.value.health_check.enabled
  health_check_interval_time = try(each.value.health_check.interval, null)
  health_check_health_num    = try(each.value.health_check.healthy_threshold, null)
  health_check_unhealth_num  = try(each.value.health_check.unhealthy_threshold, null)
  health_check_http_code     = try(each.value.health_check.matcher, null)
  health_check_http_path     = try(each.value.health_check.path, null)
  health_check_http_domain   = try(each.value.health_check.domain, null)
  health_check_http_method   = try(each.value.health_check.method, null)
  health_check_time_out      = try(each.value.health_check.timeout, null)

  certificate_ssl_mode = var.protocol == "HTTPS" ? try(each.value.tls.certificate_mode, null) : null
  certificate_id       = var.protocol == "HTTPS" ? try(each.value.tls.certificate, null) : null
  certificate_ca_id    = var.protocol == "HTTPS" && try(each.value.certificate_mode, null) == "MUTUAL" ? try(each.value.certificate_ca, null) : null

  scheduler           = each.value.load_balancing_algorithm_type
  session_expire_time = each.value.load_balancing_algorithm_type == "WRR" ? each.value.session_expire_time : null

  target_type = each.value.target_type
}
