variable "kubernetes_host" {
  type    = string
  default = "https://kubernetes.default.svc"
}

variable "vault_k8s_sa" {
  type = map(string)
}

variable "vault_bound_sa_names" {
  type = list(string)
}

variable "vault_bound_sa_namespaces" {
  type = list(string)
}
