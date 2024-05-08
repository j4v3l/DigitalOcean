output "firewall_id" {
  value = var.enable_networking_module ? digitalocean_firewall.network_firewall[0].id : "N/A"
}
