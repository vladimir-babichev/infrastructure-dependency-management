#------------------------------------------------------------------------------
# secret store
#------------------------------------------------------------------------------

resource "vault_mount" "secrets" {
  path        = "secrets"
  type        = "kv"
  description = "Secret Store"
  options     = { version : 2 }
}

#------------------------------------------------------------------------------
# kubernetes auth backend method
#------------------------------------------------------------------------------

module "k8s-auth" {
  source = "github.com/vladimir-babichev/infrastructure-dependency-management//terraform/modules/k8s-auth?ref=v0.1.0"

  kubernetes_host           = var.kubernetes_host
  vault_k8s_sa              = var.vault_k8s_sa
  vault_bound_sa_names      = var.vault_bound_sa_names
  vault_bound_sa_namespaces = var.vault_bound_sa_namespaces
}
