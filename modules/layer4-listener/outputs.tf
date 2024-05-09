output "id" {
  description = "listener ID"
  value       = tencentcloud_clb_listener.this.listener_id
}

output "name" {
  description = "listener 이름"
  value       = tencentcloud_clb_listener.this.listener_name
}

output "port" {
  description = "listener port"
  value       = tencentcloud_clb_listener.this.port
}

output "protocol" {
  description = "listener protocol"
  value       = tencentcloud_clb_listener.this.protocol
}

output "attributes" {
  description = "listener attributes"
  value = {
    load_balancing_algorithm = tencentcloud_clb_listener.this.scheduler
    session_expire_time      = tencentcloud_clb_listener.this.session_expire_time
  }
}

output "tls" {
  description = "listener tls 정보"
  value = {
    certificate_mode = tencentcloud_clb_listener.this.certificate_ssl_mode
    certificate      = tencentcloud_clb_listener.this.certificate_id
    certificate_ca   = tencentcloud_clb_listener.this.certificate_ca_id
  }
}

output "health_check" {
  description = "listener health check 정보"
  value = var.health_check.enabled ? {
    healthy_threshold   = tencentcloud_clb_listener.this.health_check_health_num
    unhealthy_threshold = tencentcloud_clb_listener.this.health_check_unhealth_num
    interval            = tencentcloud_clb_listener.this.health_check_interval_time
    path                = tencentcloud_clb_listener.this.health_check_http_path
    domain              = tencentcloud_clb_listener.this.health_check_http_domain
    success_code        = tencentcloud_clb_listener.this.health_check_http_code
    method              = tencentcloud_clb_listener.this.health_check_http_method
    timeout             = tencentcloud_clb_listener.this.health_check_time_out
    type                = tencentcloud_clb_listener.this.health_check_type
    port                = tencentcloud_clb_listener.this.health_check_port
  } : {}
}
