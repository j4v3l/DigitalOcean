variable "enable_vps_module" {
  description = "Set to true to enable the VPS module"
  type        = bool
  default     = true
}
variable "ssh_key_name" {
  description = "SSH key name"
  default     = "my-ssh-key"
}
variable "ssh_key_path" {
  description = "Path to the Public SSH Key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
}
variable "droplet_name" {
  description = "Name of the droplet to be created"
  type        = string
  default     = "prod-droplet"
}
variable "region" {
  description = "Region for the droplet"
  type        = string
  default     = "nyc3"
}
variable "image_name" {
  description = "Image name for the droplet"
  type        = string
  default     = "image_name"
}
variable "size" {
  description = "Size of the droplet"
  type        = string
  default     = "s-1vcpu-1gb"
}
variable "graceful_shutdown" {
  description = "Set to true to enable graceful shutdown"
  type        = bool
  default     = true
}
variable "tags" {
  description = "Tags to be added to the droplet"
  type        = list(string)
  default     = ["prod", "linux"]
}
variable "enable_ssh_module" {
  description = "Enable or disable the ssh_key module"
  type        = bool
  default     = true
}
variable "domain_name" {
  description = "The domain name for the environment"
  default     = "prod.example.com"
}
variable "enable_dns_module" {
  description = "Set to true to enable the DNS module"
  type        = bool
  default     = false
}
variable "subdomain_name" {
  description = "The subdomain name"
  default     = "sub"
}
variable "enable_subdomain" {
  description = "Set to true to enable the subdomain"
  type        = bool
  default     = false
}
variable "enable_networking_module" {
  description = "Enable the networking module"
  type        = bool
  default     = false
}
variable "firewall_name" {
  description = "The name of the firewall"
  type        = string
  default     = "default_firewall_name"
}

variable "monitoring" {
  description = "Set to true to enable monitoring"
  type        = bool
  default     = false

}

variable "volume_name" {
  description = "The name of the volume"
  type        = string
}

variable "volume_size" {
  description = "The size of the volume in GiB"
  type        = number
}

variable "volume_description" {
  description = "An optional description for the volume"
  type        = string
  default     = ""
}

variable "enable_storage" {
  description = "Flag to enable or disable the storage module"
  type        = bool
  default     = true
}

variable "region" {
  description = "The region where the loadbalancer will be created"
  type        = string
}
