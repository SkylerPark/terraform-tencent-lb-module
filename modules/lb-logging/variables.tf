variable "period" {
  description = "(필수) 로그 셋 보존기간(일) 최대값 `90` Default: `0`."
  type        = number
  default     = 0
  nullable    = false

  validation {
    condition     = alltrue([var.period >= 0, var.period <= 90])
    error_message = "로그셋 보존기간은 `0` 부터 `90` 까지 설정 가능."
  }
}

variable "topic_name" {
  description = "(필수) 로그 토픽 이름."
  type        = string
  default     = null
}
