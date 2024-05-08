variable "droplet_name" {
  description = "Name of the droplet to be created"
  type        = string
}
variable "region" {
  description = "Region for the droplet"
  type        = string
}
variable "ssh_key_id" {
  description = "SSH Key ID for accessing the droplet"
  type        = string
}
variable "image_name" {
  description = "Image name for the droplet"
  type        = string
}
variable "size" {
  description = "Droplet size"
  type        = string
}
variable "droplet_id" {
  description = "The ID of the droplet the volume will be attached to"
  type        = string
}
variable "enable_vps_module" {
  description = "Set to true to enable the VPS module"
  type        = bool
  default     = true

}
variable "graceful_shutdown" {
  description = "Set to true to enable graceful shutdown"
  type        = bool
  default     = true
}
variable "tags" {
  description = "Tags for the droplet"
  type        = list(string)
  default     = ["vps"]
}

variable "monitoring" {
  description = "Set to true to enable monitoring"
  type        = bool
  default     = false
}

variable "volume_id" {
  description = "The ID of the volume to attach to the droplet"
  type        = string

}

variable "enable_storage" {
  description = "Set to true to enable the storage module"
  type        = bool
  default     = false
}

# variable "enable_loadbalancer_module" {
#   description = "Set to true to enable the loadbalancer module"
#   type        = bool
#   default     = false
  
# }

# variable "loadbalancer_name" {
#   description = "The name of the loadbalancer"
#   type        = string
# }

# variable "entry_port" {
#   description = "The entry port of the loadbalancer"
#   type        = number
# }

# variable "entry_protocol" {
#   description = "The entry protocol of the loadbalancer"
#   type        = string
# }

# variable "target_port" {
#   description = "The target port of the loadbalancer"
#   type        = number
# }

# variable "target_protocol" {
#   description = "The target protocol of the loadbalancer"
#   type        = string
# }

# variable "droplet_ids" {
#   description = "List of droplet IDs to apply the loadbalancer to"
#   type        = list(string)
# }