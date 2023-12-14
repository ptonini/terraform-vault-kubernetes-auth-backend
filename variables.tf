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
  type = set(string)
  default = []
}

variable "disable_iss_validation" {
  default = true
}
