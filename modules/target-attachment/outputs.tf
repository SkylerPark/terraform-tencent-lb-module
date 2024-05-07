output "id" {
  description = "attachment ID"
  value       = tencentcloud_clb_attachment.this.id
}

output "targets" {
  description = "target 내용에 포함된 정보 리스트"
  value = {
    for name, target in var.targets : name => {
      instance_id = target.instance_id
      port        = target.port
      weight      = target.weight
    }
  }
}
