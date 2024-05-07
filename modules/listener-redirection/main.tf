resource "tencentcloud_clb_redirection" "this" {
  clb_id = var.load_balancer

  target_listener_id = var.target.listener
  target_rule_id     = var.target.rule

  source_listener_id = var.source.listener
  source_rule_id     = var.source.rule
}
