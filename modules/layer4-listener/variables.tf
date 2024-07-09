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
    condition     = contains(["TCP", "TCP_SSL", "UDP"], var.protocol)
    error_message = "다음중 하나를 선택 해야 합니다. `TCP`, `TCP_SSL`, `UDP`."
  }
}

variable "tls" {
  description = <<EOF
  (선택) TLS Listener 에 필요한 설정. `protocol` 이 `HTTPS` 일때 사용. `tls` 블록 내용.
    (선택) `certificate_mode` - 인증서 유형을 지정합니다 유효한 값. `UNIDIRECTIONAL`, `MUTUAL` Default: `UNIDIRECTIONAL`.
    (선택) `certificate` - SSL certificate arn.
    (선택) `certificate_ca` - 클라이언트 인증서 ID
  EOF
  type = object({
    certificate_mode = optional(string, "UNIDIRECTIONAL")
    certificate      = optional(string)
    certificate_ca   = optional(string)
  })
  default  = {}
  nullable = false
}


variable "health_check" {
  description = <<EOF
  (선택) listener rule health check 설정 값 `health_check` 블록 내용.
    (선택) `enabled` - health check 사용 유무. Default: false
    (선택) `interval` - 대상 확인에 대한 상태 확인 시간(초). `2` 부터 `300` 설정 가능.
    (선택) `healthy_threshold` - 정상으로 간주하기 위한 연속 상태 확인 성공 횟수. `2` 부터 `10` 설정 가능.
    (선택) `unhealthy_threshold` - 비정상으로 간주하기 위한 연속 상태 확인 실패 횟수. `2` 부터 `10` 까지 설정가능.
    (선택) `matcher` - 대상에 대한 성공 코드. `1` 부터 `31` 까지 설정 가능.
    (선택) `path` - 상태 요청에 대한 path. Default: `Default Path`
    (선택) `domain` - 상태 요청에 대한 도메인. Default: `Default Domain`
    (선택) `method` - 상태 요청에 대한 method. Default: `GET`
    (선택) `type` - 상태 요청대 대한 protocol type. Default: `TCP`
    (선택) `port` - 상태 요청에 대한 port number.
    (선택) `version` - HTTP 상태 요청에 대한 version. Default: `HTTP/1.1`
    (선택) `timeout` - 대상으로 부터 응답이 없으면 상태 확인 실패 의미하는 시간(초). `2` 부터 `60` 까지 설정 가능.
  EOF
  type = object({
    enabled             = optional(bool, false)
    timeout             = optional(number, 2)
    interval            = optional(number, 5)
    healthy_threshold   = optional(number, 3)
    unhealthy_threshold = optional(number, 3)
    matcher             = optional(number, 2)
    path                = optional(string, "Default Path")
    domain              = optional(string, "Default Domain")
    method              = optional(string, "GET")
    type                = optional(string, "TCP")
    port                = optional(number)
    version             = optional(string, "HTTP/1.1")
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      var.health_check.interval >= 2,
      var.health_check.interval <= 300,
      var.health_check.healthy_threshold >= 2,
      var.health_check.healthy_threshold <= 10,
      var.health_check.unhealthy_threshold >= 2,
      var.health_check.unhealthy_threshold <= 10,
      var.health_check.timeout >= 2,
      var.health_check.timeout <= 60,
    ])
    error_message = "`health_check` 설정값이 잘못 되었습니다."
  }
}


variable "load_balancing_algorithm_type" {
  description = "(선택) 리스너의 스케쥴링 방법. `WRR`, `IP_HASH`. `LEAST_CONN` 이 허용. Default: `LEAST_CONN`"
  type        = string
  default     = "LEAST_CONN"
  nullable    = false
}

variable "session_expire_time" {
  description = "(선택) `load_balancing_algorithm_type` 이 `WRR` 일때 사용. 수신시 내 세션 지속 시간."
  type        = number
  default     = null
}
