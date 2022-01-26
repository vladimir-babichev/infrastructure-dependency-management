resource "vault_mount" "this" {
  path                  = var.path
  type                  = "pki"
  description           = "${var.common_name} Authority"
  max_lease_ttl_seconds = var.max_lease_ttl_seconds
}

resource "vault_pki_secret_backend_intermediate_cert_request" "this" {
  backend = vault_mount.this.path

  common_name  = var.common_name
  country      = var.country
  key_bits     = var.key_bits
  organization = var.organization
  ou           = var.ou
  type         = var.type
}

resource "vault_pki_secret_backend_root_sign_intermediate" "this" {
  backend              = var.signing_path
  csr                  = vault_pki_secret_backend_intermediate_cert_request.this.csr
  common_name          = var.common_name
  exclude_cn_from_sans = var.exclude_cn_from_sans
  ttl                  = var.max_lease_ttl_seconds
}

resource "vault_pki_secret_backend_intermediate_set_signed" "this" {
  backend     = vault_mount.this.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.this.certificate
}

resource "vault_pki_secret_backend_config_urls" "config_urls" {
  backend                 = vault_mount.this.path
  issuing_certificates    = ["${var.vault_addr}/v1/${vault_mount.this.path}/ca"]
  crl_distribution_points = ["${var.vault_addr}/v1/${vault_mount.this.path}/crl"]
}
