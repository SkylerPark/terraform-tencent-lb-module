variable "load_balancer" {
  description = "(필수) Load balancer ID"
  type        = string
  nullable    = false
}

variable "name" {
  description = "(필수) listener 이름"
  type        = string
  nullable    = false
}

variable "port" {
  description = "(필수) listener 수신 port."
  type        = number
  nullable    = false
}

variable "protocol" {
  description = "(필수) listener 프로토콜."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["HTTP", "HTTPS"], var.protocol)
    error_message = "다음중 하나를 선택 해야 합니다. `HTTP` and `HTTPS`."
  }
}

variable "tls" {
  description = <<EOF
  (선택) TLS Listener 에 필요한 설정. `protocol` 이 `HTTPS` 일때 사용. `tls` 블록 내용.
    (선택) `certificate_mode` - 인증서 유형을 지정합니다 유효한 값. `UNIDIRECTIONAL`, `MUTUAL` Default: `UNIDIRECTIONAL`.
    (선택) `certificate` - SSL certificate arn.
    (선택) `certificate_ca` - 클라이언트 인증서 ID
    (선택) `sni_enabled` - SNI 활성화 여부 Default: `false`.
  EOF
  type = object({
    certificate_mode = optional(string, "UNIDIRECTIONAL")
    certificate      = optional(string)
    certificate_ca   = optional(string)
    sni_enabled      = optional(bool, false)
  })
  default  = {}
  nullable = false
}

variable "rules" {
  description = <<EOF
  (선택) listener rule 에 해당하는 설정값 `rules` 블록 내용.
    (필수) `domain` - rule 의 도메인 정보.
    (필수) `url` - rule 의 URL 정보.
    (선택) listener rule health check 설정 값 `health_check` 블록 내용.
      (선택) `enabled` - health check 사용 유무. Default: false
      (선택) `interval` - 대상 확인에 대한 상태 확인 시간(초). `2` 부터 `300` 설정 가능.
      (선택) `healthy_threshold` - 정상으로 간주하기 위한 연속 상태 확인 성공 횟수. `2` 부터 `10` 설정 가능.
      (선택) `unhealthy_threshold` - 비정상으로 간주하기 위한 연속 상태 확인 실패 횟수. `2` 부터 `10` 까지 설정가능.
      (선택) `matcher` - 대상에 대한 성공 코드. `1` 부터 `31` 까지 설정 가능.
      (선택) `path` - 상태 요청에 대한 path. Default: `Default Path`
      (선택) `domain` - 상태 요청에 대한 도메인. Default: `Default Domain`
      (선택) `method` - 상태 요청에 대한 method. Default: `GET`
      (선택) `timeout` - 대상으로 부터 응답이 없으면 상태 확인 실패 의미하는 시간(초). `2` 부터 `60` 까지 설정 가능.
    (선택) TLS Rule 에 필요한 설정. `protocol` 이 `HTTPS` 일때 사용. `tls` 블록 내용.
      (선택) `certificate_mode` - 인증서 유형을 지정합니다 유효한 값. `UNIDIRECTIONAL`, `MUTUAL` Default: `UNIDIRECTIONAL`.
      (선택) `certificate` - SSL certificate arn.
      (선택) `certificate_ca` - 클라이언트 인증서 ID
    (선택) `load_balancing_algorithm_type` - 리스너의 스케쥴링 방법. `WRR`, `IPHASH`. `LEAST_CONN` 이 허용. Default: `LEAST_CONN`
    (선택) `session_expire_time` - 수신시 내 세션 지속 시간.
    (선택) `target_type` - 백엔드 대상 유형 `NODE`, `TARGETGROUP` 으로 설정 가능. Default: `NODE`
  EOF
  type        = any
  default     = []

  validation {
    condition = alltrue([
      for rule in var.rules :
      alltrue([
        rule.health_check.interval >= 2,
        rule.health_check.interval <= 300,
        rule.health_check.healthy_threshold >= 2,
        rule.health_check.healthy_threshold <= 10,
        rule.health_check.unhealthy_threshold >= 2,
        rule.health_check.unhealthy_threshold <= 10,
        rule.health_check.timeout >= 2,
        rule.health_check.timeout <= 60,
        contains(["WRR", "IPHASH", "LEAST_CONN"], rule.load_balancing_algorithm_type),
        contains(["NODE", "TARGETGROUP"], rule.target_type)
      ])
    ])
    error_message = "`rules` 설정값이 잘못 되었습니다."
  }
}
