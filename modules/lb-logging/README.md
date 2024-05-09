# lb-logging

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
| [tencentcloud_clb_log_set.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_log_set) | resource |
| [tencentcloud_clb_log_topic.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_log_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_period"></a> [period](#input\_period) | (필수) 로그 셋 보존기간(일) 최대값 `90` Default: `0`. | `number` | `0` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | (필수) 로그 토픽 이름. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_set_id"></a> [log\_set\_id](#output\_log\_set\_id) | clb log set id |
| <a name="output_log_set_name"></a> [log\_set\_name](#output\_log\_set\_name) | clb log set name |
| <a name="output_log_set_period"></a> [log\_set\_period](#output\_log\_set\_period) | clb log set period |
| <a name="output_log_topic_id"></a> [log\_topic\_id](#output\_log\_topic\_id) | clb log topic id |
| <a name="output_log_topic_name"></a> [log\_topic\_name](#output\_log\_topic\_name) | clb log topic name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
