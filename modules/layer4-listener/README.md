# layer4-listener

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
| [tencentcloud_clb_listener.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | (선택) listener rule health check 설정 값 `health_check` 블록 내용.<br>    (선택) `enabled` - health check 사용 유무. Default: false<br>    (선택) `interval` - 대상 확인에 대한 상태 확인 시간(초). `2` 부터 `300` 설정 가능.<br>    (선택) `healthy_threshold` - 정상으로 간주하기 위한 연속 상태 확인 성공 횟수. `2` 부터 `10` 설정 가능.<br>    (선택) `unhealthy_threshold` - 비정상으로 간주하기 위한 연속 상태 확인 실패 횟수. `2` 부터 `10` 까지 설정가능.<br>    (선택) `matcher` - 대상에 대한 성공 코드. `1` 부터 `31` 까지 설정 가능.<br>    (선택) `path` - 상태 요청에 대한 path. Default: `Default Path`<br>    (선택) `domain` - 상태 요청에 대한 도메인. Default: `Default Domain`<br>    (선택) `method` - 상태 요청에 대한 method. Default: `GET`<br>    (선택) `type` - 상태 요청대 대한 protocol type. Default: `TCP`<br>    (선택) `port` - 상태 요청에 대한 port number.<br>    (선택) `version` - HTTP 상태 요청에 대한 version. Default: `HTTP/1.1`<br>    (선택) `timeout` - 대상으로 부터 응답이 없으면 상태 확인 실패 의미하는 시간(초). `2` 부터 `60` 까지 설정 가능. | <pre>object({<br>    enabled             = optional(bool, false)<br>    timeout             = optional(number, 2)<br>    interval            = optional(number, 5)<br>    healthy_threshold   = optional(number, 3)<br>    unhealthy_threshold = optional(number, 3)<br>    matcher             = optional(number, 2)<br>    path                = optional(string, "Default Path")<br>    domain              = optional(string, "Default Domain")<br>    method              = optional(string, "GET")<br>    type                = optional(string, "TCP")<br>    port                = optional(number)<br>    version             = optional(string, "HTTP/1.1")<br>  })</pre> | `{}` | no |
| <a name="input_load_balancer"></a> [load\_balancer](#input\_load\_balancer) | (필수) Load balancer ID | `string` | n/a | yes |
| <a name="input_load_balancing_algorithm_type"></a> [load\_balancing\_algorithm\_type](#input\_load\_balancing\_algorithm\_type) | (선택) 리스너의 스케쥴링 방법. `WRR`, `IP_HASH`. `LEAST_CONN` 이 허용. Default: `LEAST_CONN` | `string` | `"LEAST_CONN"` | no |
| <a name="input_name"></a> [name](#input\_name) | (필수) listener 이름 | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | (필수) listener 수신 port. | `number` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | (필수) listener 프로토콜. | `string` | n/a | yes |
| <a name="input_session_expire_time"></a> [session\_expire\_time](#input\_session\_expire\_time) | (선택) `load_balancing_algorithm_type` 이 `WRR` 일때 사용. 수신시 내 세션 지속 시간. | `number` | `null` | no |
| <a name="input_tls"></a> [tls](#input\_tls) | (선택) TLS Listener 에 필요한 설정. `protocol` 이 `HTTPS` 일때 사용. `tls` 블록 내용.<br>    (선택) `certificate_mode` - 인증서 유형을 지정합니다 유효한 값. `UNIDIRECTIONAL`, `MUTUAL` Default: `UNIDIRECTIONAL`.<br>    (선택) `certificate` - SSL certificate arn.<br>    (선택) `certificate_ca` - 클라이언트 인증서 ID | <pre>object({<br>    certificate_mode = optional(string, "UNIDIRECTIONAL")<br>    certificate      = optional(string)<br>    certificate_ca   = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_attributes"></a> [attributes](#output\_attributes) | listener attributes |
| <a name="output_health_check"></a> [health\_check](#output\_health\_check) | listener health check 정보 |
| <a name="output_id"></a> [id](#output\_id) | listener ID |
| <a name="output_name"></a> [name](#output\_name) | listener 이름 |
| <a name="output_port"></a> [port](#output\_port) | listener port |
| <a name="output_protocol"></a> [protocol](#output\_protocol) | listener protocol |
| <a name="output_tls"></a> [tls](#output\_tls) | listener tls 정보 |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
