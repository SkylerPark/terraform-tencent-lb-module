resource "tencentcloud_clb_attachment" "this" {
  clb_id      = var.load_balancer
  listener_id = var.listener
  rule_id     = var.rule

  dynamic "targets" {
    for_each = [var.targets]
    content {
      instance_id = targets.value.instance_id
      port        = targets.value.port
      weight      = targets.value.weight
    }
  }
}
