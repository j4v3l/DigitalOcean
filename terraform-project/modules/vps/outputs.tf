output "droplet_ip" {
  value = var.enable_vps_module ? digitalocean_droplet.vps[0].ipv4_address : "N/A"
}

output "droplet_id_output" {
  value = var.enable_vps_module ? digitalocean_droplet.vps[0].id : "N/A"
}
