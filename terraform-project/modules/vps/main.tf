terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_droplet" "vps" {
  count             = var.enable_vps_module ? 1 : 0
  name              = var.droplet_name
  size              = var.size
  region            = var.region
  image             = var.image_name
  ssh_keys          = [var.ssh_key_id]
  graceful_shutdown = var.graceful_shutdown
  monitoring        = var.monitoring
  tags              = var.tags
}

resource "digitalocean_volume_attachment" "vps_volume_attachment" {
  count      = var.enable_storage ? length(digitalocean_droplet.vps) : 0
  droplet_id = digitalocean_droplet.vps[count.index].id
  volume_id  = var.volume_id
}

# resource "digitalocean_loadbalancer" "loadbalancer" {
#   count  = var.enable_loadbalancer_module ? 1 : 0
#   name   = var.loadbalancer_name
#   region = var.region
#   forwarding_rule {
#     entry_port     = var.entry_port
#     entry_protocol = var.entry_protocol
#     target_port     = var.target_port
#     target_protocol = var.target_protocol
#   }
#   droplet_ids = var.enable_vps_module ? [module.vps[0].droplet_id] : []
# }