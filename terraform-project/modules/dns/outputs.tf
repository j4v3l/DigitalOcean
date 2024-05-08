output "domain_name" {
  value = var.enable_dns_module ? digitalocean_domain.domain[0].name : "N/A"
}
