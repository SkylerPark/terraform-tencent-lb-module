resource "tencentcloud_clb_redirection" "this" {
  clb_id = var.load_balancer

  target_listener_id = var.redirection_target.listener
  target_rule_id     = var.redirection_target.rule

  source_listener_id = var.redirection_source.listener
  source_rule_id     = var.redirection_source.rule
}
