resource "tencentcloud_clb_listener" "this" {
  clb_id = var.load_balancer

  listener_name = var.name
  port          = var.port
  protocol      = var.protocol

  certificate_ssl_mode = var.protocol == "TCP_SSL" ? var.tls.certificate_mode : null
  certificate_id       = var.protocol == "TCP_SSL" ? var.tls.certificate : null
  certificate_ca_id    = var.protocol == "TCP_SSL" && var.tls.certificate_mode == "MUTUAL" ? var.tls.certificate_ca : null

  health_check_switch        = var.health_check.enabled
  health_check_time_out      = var.health_check.timeout
  health_check_interval_time = var.health_check.interval
  health_check_health_num    = var.health_check.healthy_threshold
  health_check_unhealth_num  = var.health_check.unhealthy_threshold
  health_check_type          = var.health_check.type
  health_check_port          = var.health_check.port

  health_check_http_code    = var.health_check.matcher
  health_check_http_path    = var.health_check.path
  health_check_http_domain  = var.health_check.domain
  health_check_http_method  = var.health_check.method
  health_check_http_version = var.health_check.version

  session_expire_time = var.load_balancing_algorithm_type == "WRR" ? var.session_expire_time : null
  scheduler           = var.load_balancing_algorithm_type
}
