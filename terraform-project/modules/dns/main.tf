terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_domain" "domain" {
  count      = var.enable_dns_module ? 1 : 0
  name       = var.domain_name
  ip_address = var.ip_address
}

resource "digitalocean_record" "sub" {
  count  = var.enable_subdomain ? 1 : 0
  domain = var.domain_name
  type   = "A"
  name   = var.subdomain_name
  value  = var.subdomain_ip
}
