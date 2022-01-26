resource "vault_policy" "k8s-secrets-ro" {
  name = "k8s-secrets-ro"

  policy = <<EOT
path "secrets/metadata/k8s/" {
  capabilities = ["list"]
}

path "secrets/data/k8s/*" {
  capabilities = ["read"]
}
EOT
}

data "kubernetes_service_account" "main" {
  metadata {
    name      = var.vault_k8s_sa.name
    namespace = var.vault_k8s_sa.namespace
  }
}

data "kubernetes_secret" "main" {
  metadata {
    name      = data.kubernetes_service_account.main.default_secret_name
    namespace = var.vault_k8s_sa.namespace
  }
}

resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "main" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = var.kubernetes_host
  kubernetes_ca_cert     = data.kubernetes_secret.main.data["ca.crt"]
  token_reviewer_jwt     = data.kubernetes_secret.main.data["token"]
  disable_iss_validation = true
}

resource "vault_kubernetes_auth_backend_role" "k8s-secrets-ro" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "k8s-secrets-ro"
  bound_service_account_names      = var.vault_bound_sa_names
  bound_service_account_namespaces = var.vault_bound_sa_namespaces
  token_ttl                        = 3600
  token_policies                   = ["k8s-secrets-ro"]
}
