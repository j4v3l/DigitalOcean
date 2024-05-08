terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_volume" "storage" {
  region      = var.region
  name        = var.volume_name
  size        = var.volume_size
  description = var.volume_description
  initial_filesystem_type = var.initial_filesystem_type
  initial_filesystem_label = var.initial_filesystem_label
}
