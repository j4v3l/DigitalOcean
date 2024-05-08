output "volume_id" {
  description = "The ID of the created volume"
  value       = digitalocean_volume.storage.id
}