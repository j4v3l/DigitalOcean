variable "ssh_key_name" {
  description = "Name of the SSH key on DigitalOcean"
  type        = string
}

variable "ssh_key_public" {
  description = "Public SSH key data"
  type        = string
}

variable "enable_ssh_module" {
  description = "Set to true to enable the SSH key module"
  type        = bool
  default     = true
}
