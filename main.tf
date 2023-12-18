resource "vault_auth_backend" "this" {
  type = var.type
  path = var.path
}

resource "vault_kubernetes_auth_backend_config" "this" {
  backend                = vault_auth_backend.this.path
  kubernetes_host        = var.kubernetes_host
  kubernetes_ca_cert     = var.kubernetes_ca_cert
  token_reviewer_jwt     = var.token_reviewer_jwt
  pem_keys               = var.pem_keys
  disable_iss_validation = var.disable_iss_validation
}

module "roles" {
  source                           = "ptonini/kubernetes-auth-role/vault"
  version                          = "~> 1.1.1"
  for_each                         = var.roles
  name                             = each.key
  backend                          = vault_auth_backend.this.path
  bound_service_account_names      = coalesce(each.value.bound_service_account_names, [each.key])
  bound_service_account_namespaces = each.value.bound_service_account_namespaces
  policy_definitions               = each.value.policy_definitions
}