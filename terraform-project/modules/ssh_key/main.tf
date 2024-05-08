terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_ssh_key" "ssh_key" {
  count      = var.enable_ssh_module ? 1 : 0
  name       = var.ssh_key_name
  public_key = var.ssh_key_public
}
