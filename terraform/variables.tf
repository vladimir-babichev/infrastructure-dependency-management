variable "kubernetes_host" { default = "https://kubernetes.default.svc" }

variable "vault_bootstrap_addr" {
  default = "http://127.0.0.1:8200"
}
variable "vault_addr" {
  default = "http://vault.core.svc:8200"
}
variable "vault_k8s_sa" {
  default = {
    name      = "vault"
    namespace = "core"
  }
}
variable "vault_bound_sa_names" {
  default = ["argocd-repo-server"]
}
variable "vault_bound_sa_namespaces" {
  default = ["gitops"]
}
