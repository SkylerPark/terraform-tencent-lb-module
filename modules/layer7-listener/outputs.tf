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

output "tls" {
  description = "listener tls 정보"
  value = {
    certificate_mode = tencentcloud_clb_listener.this.certificate_ssl_mode
    certificate      = tencentcloud_clb_listener.this.certificate_id
    certificate_ca   = tencentcloud_clb_listener.this.certificate_ca_id
    sni_enabled      = tencentcloud_clb_listener.this.sni_switch
  }
}

output "rules" {
  description = "listener Rule 정보"
  value = {
    for rule in var.rules :
    "${rule.domain}${rule.url}" => {
      id     = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].rule_id
      domain = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].domain
      url    = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].url
      attributes = {
        load_balancing_algorithm = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].scheduler
        session_expire_time      = try(tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].session_expire_time, null)
      }
      health_check = rule.health_check.enabled ? {
        healthy_threshold   = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].health_check_health_num
        unhealthy_threshold = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].health_check_unhealth_num
        interval            = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].health_check_interval_time
        path                = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].health_check_http_path
        domain              = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].health_check_http_domain
        success_code        = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].health_check_http_code
        method              = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].health_check_http_method
        timeout             = tencentcloud_clb_listener_rule.this["${rule.domain}${rule.url}"].health_check_time_out
      } : {}
    }
  }
}
