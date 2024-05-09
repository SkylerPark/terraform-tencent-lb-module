variable "load_balancer" {
  description = "(필수) Load balancer ID"
  type        = string
  nullable    = false
}

variable "listener" {
  description = "(필수) Listener ID"
  type        = string
  nullable    = false
}

variable "rule" {
  description = "(선택) Rule ID"
  type        = string
  default     = null
}

variable "targets" {
  description = <<EOF
  (선택) 대상에 대한 설정 `targets` 블록 내용.
    (필수) `instance_id` - 대상이 되는 instance ID.
    (필수) `port` - 대상이 되는 instance Port.
    (선택) `weight` - 대상에 대한 가중치 Default: `100`
  EOF
  type = list(object({
    instance_id = optional(string)
    port        = optional(number)
    weight      = optional(number, 100)
  }))
  default  = []
  nullable = false
}
