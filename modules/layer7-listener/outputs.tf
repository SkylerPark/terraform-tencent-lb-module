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

output "rules" {
  description = "listener Rule 정보"
  value = {
    for rule in var.rules :
    "${rule.domain}-${rule.url}" => {
      id     = tencentcloud_clb_listener_rule[each.key].rule_id
      domain = tencentcloud_clb_listener_rule[each.key].domain
      url    = tencentcloud_clb_listener_rule[each.key].url
      attributes = {
        load_balancing_algorithm = tencentcloud_clb_listener_rule.this[each.key].scheduler
        session_expire_time      = try(tencentcloud_clb_listener_rule.this[each.key].session_expire_time, null)
      }
      health_check = {
        healthy_threshold   = tencentcloud_clb_listener_rule.this[each.key].health_check_health_num
        unhealthy_threshold = tencentcloud_clb_listener_rule.this[each.key].health_check_unhealth_num
        interval            = tencentcloud_clb_listener_rule.this[each.key].health_check_interval_time
        path                = tencentcloud_clb_listener_rule.this[each.key].health_check_http_path
        domain              = tencentcloud_clb_listener_rule.this[each.key].health_check_http_domain
        success_codes       = tencentcloud_clb_listener_rule.this[each.key].health_check_http_code
        method              = tencentcloud_clb_listener_rule.this[each.key].health_check_http_method
        timeout             = tencentcloud_clb_listener_rule.this[each.key].health_check_time_out
      }
    }
  }
}
