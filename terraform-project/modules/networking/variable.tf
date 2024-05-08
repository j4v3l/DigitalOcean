variable "firewall_name" {
  description = "Name of the firewall"
  type        = string
}

variable "droplet_ids" {
  description = "List of droplet IDs to apply the firewall to"
  type        = list(string)
}

variable "enable_networking_module" {
  description = "Set to true to enable the networking module"
  type        = bool
  default     = true
}
