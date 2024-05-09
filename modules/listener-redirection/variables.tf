variable "load_balancer" {
  description = "(필수) Load balancer ID"
  type        = string
  nullable    = false
}

variable "redirection_target" {
  description = <<EOF
  (선택) 대상이 되는 정보 `target` 블록 내용.
    (선택) `listener` - 대상 listener ID.
    (선택) `rule` - 대상 rule ID.
  EOF
  type = object({
    listener = optional(string, null)
    rule     = optional(string, null)
  })
  default = {}
}

variable "redirection_source" {
  description = <<EOF
  (선택) redirection 이 될 정보 `source` 블록 내용.
    (선택) `listener` - 대상 listener ID.
    (선택) `rule` - 대상 rule ID.
  EOF
  type = object({
    listener = optional(string, null)
    rule     = optional(string, null)
  })
  default = {}
}
