# layer7-instance

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_access_log"></a> [access\_log](#module\_access\_log) | ../lb-logging | n/a |
| <a name="module_listener"></a> [listener](#module\_listener) | ../layer7-listener | n/a |

## Resources

| Name | Type |
|------|------|
| [tencentcloud_clb_instance.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_log"></a> [access\_log](#input\_access\_log) | (선택) access log 에 대한 설정. `access_log` 블록 내용.<br>    (선택) `enabled` - access log 를 활성화 할지에 대한 여부 Default: `false`.<br>    (선택) `period` - access log 보존일 설정 최대값 `90` Default: `1`.<br>    (선택) `topic_name` - access log 토픽 이름. | <pre>object({<br>    enabled    = optional(bool, false)<br>    period     = optional(number, 1)<br>    topic_name = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | (선택) load balancer 의 cross zone 설정 리스트에 `첫번째`는 `master zone`. `두번째`는 `slave zone` 으로 설정. | `list(string)` | `[]` | no |
| <a name="input_bandwidth_max_out"></a> [bandwidth\_max\_out](#input\_bandwidth\_max\_out) | (선택) `is_public` `true` 일때 설정. 최대 대역폭에 대한 설정 가능한값 `1` 부터 `2048` Default: `1` | `number` | `1` | no |
| <a name="input_bandwidth_package_id"></a> [bandwidth\_package\_id](#input\_bandwidth\_package\_id) | (선택) `is_public` `true` 일때 설정. 대역폭 패키지 ID. | `string` | `null` | no |
| <a name="input_charge_type"></a> [charge\_type](#input\_charge\_type) | (선택) `is_public` `true` 일때 설정. 인터넷 요금에 대한 과금 방식. 가능한 값은 `TRAFFIC_POSTPAID_BY_HOUR`, `BANDWIDTH_POSTPAID_BY_HOUR`, `BANDWIDTH_PACKAGE`  Default: `TRAFFIC_POSTPAID_BY_HOUR` | `string` | `"TRAFFIC_POSTPAID_BY_HOUR"` | no |
| <a name="input_delete_protect_enabled"></a> [delete\_protect\_enabled](#input\_delete\_protect\_enabled) | (선택) load balancer instance 삭제 방지 유무. default: `false` | `bool` | `false` | no |
| <a name="input_is_public"></a> [is\_public](#input\_is\_public) | (필수) load balancer 가 public 으로 할당할지 여부 Default: `true` | `bool` | `true` | no |
| <a name="input_lcu"></a> [lcu](#input\_lcu) | (선택) LCU 지원 인스턴스에 대한 설정 `lcu` 블록 내용.<br>    (선택) `enabled` - LCU 지원 인스턴스를 활성화 할지에 대한 여부. Default: `false`<br>    (선택) `type` - LCU 지원 인스턴스 type `https://www.tencentcloud.com/document/product/214/54820?has_map=1` 참고. `STANDARD`, `ADVANCED_1`, `ADVANCED_2`, `SUPER_LARGE_1`, `SUPER_LARGE_2`, `SUPER_LARGE_3`, `SUPER_LARGE_4` 설정 가능. Default: `STANDARD` | <pre>object({<br>    enabled = optional(bool, false)<br>    type    = optional(string, "STANDARD")<br>  })</pre> | `{}` | no |
| <a name="input_listeners"></a> [listeners](#input\_listeners) | (선택) load balancer 리스너 목록 입니다. `listeners` 블록 내용.<br>    (필수) `port` - load balancer 리스너 포트 정보.<br>    (필수) `protocol` - load balancer 리스너 protocol 정보. 가능 한 값`HTTP` and `HTTPS`.<br>    (선택) `rules` - 리스너에 정의되는 규칙에 따라 로드 밸런서가 하나 이상의 대상 그룹에 있는 대상으로 요청을 라우팅하는 방법을 정의.<br>    (선택) `tls` - TLS Listener 에 필요한 설정. `protocol` 이 `HTTPS` 일때 사용. `tls` 블록 내용.<br>      (선택) `certificate_mode` - 인증서 유형을 지정합니다 유효한 값. `UNIDIRECTIONAL`, `MUTUAL` Default: `UNIDIRECTIONAL`.<br>      (선택) `certificate` - SSL certificate arn.<br>      (선택) `certificate_ca` - 클라이언트 인증서 ID<br>      (선택) `sni_enabled` - SNI 활성화 여부 Default: `false`. | `any` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | (필수) load balancer 인스턴스 이름 | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (필수) load balancer 생성될 Project ID, default: `0`. | `number` | `0` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | (선택) load balancer 에 추가할 security group 리스트. | `list(string)` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (선택) `is_public` 가 `false` 일 경우에만 사용가능하며 내부 load balancer의 subnet\_id. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (선택) 리소스 태그 내용 | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (필수) load balancer 가 생성 될 VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bandwidth_max_out"></a> [bandwidth\_max\_out](#output\_bandwidth\_max\_out) | load balancer bandwidth max out |
| <a name="output_domain"></a> [domain](#output\_domain) | load balancer DNS name. |
| <a name="output_id"></a> [id](#output\_id) | load balancer id |
| <a name="output_ip_address_type"></a> [ip\_address\_type](#output\_ip\_address\_type) | load balancer IP Type. |
| <a name="output_is_public"></a> [is\_public](#output\_is\_public) | load balancer public 으로 할당중인지 여부 |
| <a name="output_listeners"></a> [listeners](#output\_listeners) | load balancer listener 리스트 |
| <a name="output_name"></a> [name](#output\_name) | load balancer Name |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | load balancer 가 생성된 Subnet ID |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | load balancer 가 생성된 VPC ID |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | load balancer zone |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
