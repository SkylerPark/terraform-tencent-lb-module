# listener-redirection

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
| [tencentcloud_clb_redirection.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_redirection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_load_balancer"></a> [load\_balancer](#input\_load\_balancer) | (필수) Load balancer ID | `string` | n/a | yes |
| <a name="input_redirection_source"></a> [redirection\_source](#input\_redirection\_source) | (선택) redirection 이 될 정보 `source` 블록 내용.<br>    (선택) `listener` - 대상 listener ID.<br>    (선택) `rule` - 대상 rule ID. | <pre>object({<br>    listener = optional(string, null)<br>    rule     = optional(string, null)<br>  })</pre> | `{}` | no |
| <a name="input_redirection_target"></a> [redirection\_target](#input\_redirection\_target) | (선택) 대상이 되는 정보 `target` 블록 내용.<br>    (선택) `listener` - 대상 listener ID.<br>    (선택) `rule` - 대상 rule ID. | <pre>object({<br>    listener = optional(string, null)<br>    rule     = optional(string, null)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_redirection_source"></a> [redirection\_source](#output\_redirection\_source) | redirection 되는 정보 |
| <a name="output_redirection_target"></a> [redirection\_target](#output\_redirection\_target) | redirection 대상 정보 |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
