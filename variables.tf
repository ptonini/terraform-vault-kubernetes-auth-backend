variable "type" {
  default = "kubernetes"
}

variable "path" {
  default = "kubernetes"
}

variable "kubernetes_host" {}

variable "kubernetes_ca_cert" {}

variable "token_reviewer_jwt" {}

variable "pem_keys" {
  type    = set(string)
  default = []
}

variable "disable_iss_validation" {
  default = true
}

variable "roles" {
  type = map(object({
    name                             = optional(string)
    audience                         = optional(string)
    token_ttl                        = optional(number)
    token_max_ttl                    = optional(number)
    bound_service_account_names      = optional(set(string))
    bound_service_account_namespaces = optional(set(string))
    policies                         = optional(list(string))
    policy_definitions               = optional(list(string))
  }))
}
