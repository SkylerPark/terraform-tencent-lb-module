output "source" {
  description = "redirection 되는 정보"
  value = {
    listener = tencentcloud_clb_redirection.this.source_listener_id
    rule     = tencentcloud_clb_redirection.this.source_rule_id
  }
}

output "target" {
  description = "redirection 대상 정보"
  value = {
    listener = tencentcloud_clb_redirection.this.target_listener_id
    rule     = tencentcloud_clb_redirection.this.target_rule_id
  }
}
