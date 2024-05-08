output "droplet_ip" {
  value = var.enable_vps_module ? module.prod_vps[0].droplet_ip : "N/A"
}

output "droplet_id" {
  value = var.enable_vps_module ? module.prod_vps[0].droplet_id_output : "N/A"
}

output "domain_name" {
  value = var.enable_dns_module ? module.dns.domain_name : "N/A"
}

output "subdomain_name" {
  description = "The subdomain name"
  value       = var.enable_dns_module ? module.dns.subdomain_name : "N/A"
}
