resource "tencentcloud_clb_log_set" "this" {
  period = var.period
}

resource "tencentcloud_clb_log_topic" "this" {
  log_set_id = tencentcloud_clb_log_set.this.id
  topic_name = var.topic_name
}
