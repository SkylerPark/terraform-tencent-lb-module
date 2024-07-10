variable "name" {
  description = "(필수) load balancer 인스턴스 이름"
  type        = string
  nullable    = false
}

variable "project_id" {
  description = "(필수) load balancer 생성될 Project ID, default: `0`."
  type        = number
  default     = 0
  nullable    = false
}

variable "access_log" {
  description = <<EOF
  (선택) access log 에 대한 설정. `access_log` 블록 내용.
    (선택) `enabled` - access log 를 활성화 할지에 대한 여부 Default: `false`.
    (선택) `period` - access log 보존일 설정 최대값 `90` Default: `1`.
    (선택) `topic_name` - access log 토픽 이름.
  EOF
  type = object({
    enabled    = optional(bool, false)
    period     = optional(number, 1)
    topic_name = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      var.access_log.period >= 1,
      var.access_log.period <= 90
      ]
    )
    error_message = "`access log` 설정에 대한 parameter 가 잘못 되었습니다."
  }
}

variable "subnet_id" {
  description = "(선택) `is_public` 가 `false` 일 경우에만 사용가능하며 내부 load balancer의 subnet_id."
  type        = string
  default     = null
}

variable "is_public" {
  description = "(필수) load balancer 가 public 으로 할당할지 여부 Default: `true`"
  type        = bool
  default     = true
  nullable    = false
}

variable "vpc_id" {
  description = "(필수) load balancer 가 생성 될 VPC ID"
  type        = string
  nullable    = false
}

variable "security_groups" {
  description = "(선택) load balancer 에 추가할 security group 리스트."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "availability_zones" {
  description = "(선택) load balancer 의 cross zone 설정 리스트에 `첫번째`는 `master zone`. `두번째`는 `slave zone` 으로 설정."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "delete_protect_enabled" {
  description = "(선택) load balancer instance 삭제 방지 유무. default: `false`"
  type        = bool
  default     = false
  nullable    = false
}

variable "bandwidth_max_out" {
  description = "(선택) `is_public` `true` 일때 설정. 최대 대역폭에 대한 설정 가능한값 `1` 부터 `2048` Default: `1`"
  type        = number
  default     = 1
  nullable    = false

  validation {
    condition = alltrue([
      var.bandwidth_max_out >= 1,
      var.bandwidth_max_out <= 2048
      ]
    )
    error_message = "`bandwidth_max_out` 설정은 1-2048 내에서 설정 가능합니다."
  }
}

variable "bandwidth_package_id" {
  description = "(선택) `is_public` `true` 일때 설정. 대역폭 패키지 ID."
  type        = string
  default     = null
}

variable "charge_type" {
  description = "(선택) `is_public` `true` 일때 설정. 인터넷 요금에 대한 과금 방식. 가능한 값은 `TRAFFIC_POSTPAID_BY_HOUR`, `BANDWIDTH_POSTPAID_BY_HOUR`, `BANDWIDTH_PACKAGE`  Default: `TRAFFIC_POSTPAID_BY_HOUR`"
  type        = string
  default     = "TRAFFIC_POSTPAID_BY_HOUR"
  nullable    = false
  validation {
    condition     = contains(["TRAFFIC_POSTPAID_BY_HOUR", "BANDWIDTH_POSTPAID_BY_HOUR", "BANDWIDTH_PACKAGE"], var.charge_type)
    error_message = "`charge_type` 과금 방식은 `TRAFFIC_POSTPAID_BY_HOUR`, `BANDWIDTH_POSTPAID_BY_HOUR`, `BANDWIDTH_PACKAGE`설정 가능."
  }
}

variable "lcu" {
  description = <<EOF
  (선택) LCU 지원 인스턴스에 대한 설정 `lcu` 블록 내용.
    (선택) `enabled` - LCU 지원 인스턴스를 활성화 할지에 대한 여부. Default: `false`
    (선택) `type` - LCU 지원 인스턴스 type `https://www.tencentcloud.com/document/product/214/54820?has_map=1` 참고. `STANDARD`, `ADVANCED_1`, `ADVANCED_2`, `SUPER_LARGE_1`, `SUPER_LARGE_2`, `SUPER_LARGE_3`, `SUPER_LARGE_4` 설정 가능. Default: `STANDARD`
  EOF
  type = object({
    enabled = optional(bool, false)
    type    = optional(string, "STANDARD")
  })
  default  = {}
  nullable = false
  validation {
    condition     = contains(["STANDARD", "ADVANCED_1", "ADVANCED_2", "SUPER_LARGE_1", "SUPER_LARGE_2", "SUPER_LARGE_3", "SUPER_LARGE_4"], var.lcu.type)
    error_message = "`lcu type` 이 잘못 되었습니다. `STANDARD`, `ADVANCED_1`, `ADVANCED_2`, `SUPER_LARGE_1`, `SUPER_LARGE_2`, `SUPER_LARGE_3`, `SUPER_LARGE_4` 중 하나를 선택 해 주세요."
  }
}

variable "tags" {
  description = "(선택) 리소스 태그 내용"
  type        = map(string)
  default     = {}
}

variable "listeners" {
  description = <<EOF
  (선택) load balancer 리스너 목록 입니다. `listeners` 블록 내용.
    (필수) `port` - load balancer 리스너 포트 정보.
    (필수) `protocol` - load balancer 리스너 protocol 정보. 가능 한 값 `TCP`, `TCP_TLS`, `UDP`.
    (선택) `health_check` - load balancer 리스너 health check 정보.
    (선택) `load_balancing_algorithm_type` - 리스너의 스케쥴링 방법. `WRR`, `IPHASH`. `LEAST_CONN` 이 허용. Default: `LEAST_CONN`
    (선택) `session_expire_time` - 수신시 내 세션 지속 시간.
    (선택) `tls` - TLS Listener 에 필요한 설정. `protocol` 이 `TCP_TLS` 일때 사용. `tls` 블록 내용.
      (선택) `certificate_mode` - 인증서 유형을 지정합니다 유효한 값. `UNIDIRECTIONAL`, `MUTUAL` Default: `UNIDIRECTIONAL`.
      (선택) `certificate` - SSL certificate arn.
      (선택) `certificate_ca` - 클라이언트 인증서 ID
  EOF
  type        = any
  default     = []
  nullable    = false
}

###################################################
# ElasticIP
###################################################
variable "eip_enabled" {
  description = "(선택) LB 에 Elastic IP 할당 여부"
  type        = bool
  default     = false
}

variable "eip_tags" {
  description = "(선택) ElasticIP 태그 내용"
  type        = map(string)
  default     = {}
}
