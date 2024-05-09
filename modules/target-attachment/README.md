# target-attachment

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 0.13.0 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >1.18.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >1.18.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_clb_attachment.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_listener"></a> [listener](#input\_listener) | (필수) Listener ID | `string` | n/a | yes |
| <a name="input_load_balancer"></a> [load\_balancer](#input\_load\_balancer) | (필수) Load balancer ID | `string` | n/a | yes |
| <a name="input_rule"></a> [rule](#input\_rule) | (선택) Rule ID | `string` | `null` | no |
| <a name="input_targets"></a> [targets](#input\_targets) | (선택) 대상에 대한 설정 `targets` 블록 내용.<br>    (필수) `instance_id` - 대상이 되는 instance ID.<br>    (필수) `port` - 대상이 되는 instance Port.<br>    (선택) `weight` - 대상에 대한 가중치 Default: `100` | <pre>list(object({<br>    instance_id = optional(string)<br>    port        = optional(number)<br>    weight      = optional(number, 100)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | attachment ID |
| <a name="output_targets"></a> [targets](#output\_targets) | target 내용에 포함된 정보 리스트 |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
