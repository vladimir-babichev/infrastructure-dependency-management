resource "vault_mount" "this" {
  path                  = var.path
  type                  = "pki"
  description           = "${var.common_name} Authority"
  max_lease_ttl_seconds = var.max_lease_ttl_seconds
}


resource "vault_pki_secret_backend_config_urls" "config_urls" {
  backend                 = vault_mount.this.path
  issuing_certificates    = ["${var.vault_addr}/v1/${vault_mount.this.path}/ca"]
  crl_distribution_points = ["${var.vault_addr}/v1/${vault_mount.this.path}/crl"]
}

resource "vault_pki_secret_backend_root_cert" "this" {
  depends_on = [vault_mount.this]
  backend    = vault_mount.this.path

  common_name          = var.common_name
  country              = var.country
  exclude_cn_from_sans = var.exclude_cn_from_sans
  key_bits             = var.key_bits
  organization         = var.organization
  ou                   = var.ou
  ttl                  = var.max_lease_ttl_seconds
  type                 = var.type
}
