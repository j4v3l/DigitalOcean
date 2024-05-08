output "ssh_key_id" {
  description = "The ID of the SSH key"
  value       = var.enable_ssh_module ? digitalocean_ssh_key.ssh_key[0].id : "N/A"
}
