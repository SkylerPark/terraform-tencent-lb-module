output "log_set_id" {
  description = "clb log set id"
  value       = tencentcloud_clb_log_set.this.id
}

output "log_set_name" {
  description = "clb log set name"
  value       = tencentcloud_clb_log_set.this.name
}

output "log_set_period" {
  description = "clb log set period"
  value       = tencentcloud_clb_log_set.this.period
}

output "log_topic_id" {
  description = "clb log topic id"
  value       = tencentcloud_clb_log_topic.this.id
}

output "log_topic_name" {
  description = "clb log topic name"
  value       = tencentcloud_clb_log_topic.this.topic_name
}
