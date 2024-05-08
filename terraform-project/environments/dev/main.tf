terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

module "dev_vps" {
  source            = "../../modules/vps"
  count             = var.enable_vps_module ? 1 : 0
  droplet_name      = var.droplet_name
  size              = var.size
  region            = var.region
  image_name        = var.image_name
  ssh_key_id        = module.ssh_key.ssh_key_id
  droplet_id        = module.dev_vps[0].droplet_id_output
  graceful_shutdown = var.graceful_shutdown
  monitoring        = var.monitoring
  tags              = var.tags
  volume_id         = var.enable_storage ? module.storage[0].volume_id : null
}

module "ssh_key" {
  source            = "../../modules/ssh_key"
  enable_ssh_module = var.enable_ssh_module
  ssh_key_name      = var.ssh_key_name
  ssh_key_public    = file(var.ssh_key_path)
}

module "dns" {
  source            = "../../modules/dns"
  enable_dns_module = var.enable_dns_module
  enable_subdomain  = var.enable_subdomain
  domain_name       = var.domain_name
  ip_address        = var.enable_vps_module ? module.dev_vps[0].droplet_ip : "N/A"
  subdomain_name    = var.enable_subdomain
  subdomain_ip      = var.enable_vps_module ? module.dev_vps[0].droplet_ip : "N/A"
}

module "networking" {
  source                   = "../../modules/networking"
  enable_networking_module = var.enable_networking_module
  firewall_name            = var.firewall_name
  droplet_ids              = [module.dev_vps[0].droplet_id_output]
}

module "storage" {
  source             = "../../modules/storage"
  region             = var.region
  volume_name        = var.volume_name
  volume_size        = var.volume_size
  volume_description = var.volume_description
  count              = var.enable_storage ? 1 : 0
  droplet_id_output  = var.enable_vps_module ? module.dev_vps[0].droplet_id_output : null
  droplet_ids        = [module.dev_vps[0].droplet_id_output]
}
