module "service_account" {
  source = "github.com/ptonini/terraform-kubernetes-service-account"
  name = var.service_account_name
  namespace = var.service_account_namespace
  cluster_role_bindings = [
    "system:auth-delegator"
  ]
  providers = {
    kubernetes = kubernetes
  }
}

module "auth_backend" {
  source = "github.com/ptonini/terraform-vault-auth-backend"
  type = var.type
  path = var.path
}

resource "vault_kubernetes_auth_backend_config" "this" {
  backend = module.auth_backend.this.path
  kubernetes_host = var.host
  kubernetes_ca_cert = module.service_account.ca_crt
  token_reviewer_jwt = module.service_account.token
  pem_keys = []
  disable_iss_validation = true
}