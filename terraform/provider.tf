locals {
  vault_addr = var.vault_bootstrap_addr == "" ? var.vault_addr : var.vault_bootstrap_addr
}
terraform {
  required_version = ">= 0.12"

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "vault" {
  address = local.vault_addr
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
