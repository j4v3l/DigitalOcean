variable "region" {
  description = "The region where the volume will be created"
  type        = string
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

variable "enable_vps_module" {
  description = "Flag to enable or disable the VPS module"
  type        = bool
  default     = false

}

variable "droplet_id_output" {
  description = "The output droplet ID from the VPS module"
  type        = string
  default     = null
}
variable "droplet_ids" {
  description = "List of droplet IDs to apply the firewall to"
  type        = list(string)
}

variable "initial_filesystem_label" {
  description = "The label to apply to the initial filesystem"
  type        = string
  default     = "dev-storage"
  
}

variable "initial_filesystem_type" {
  description = "The type of filesystem to create on the volume"
  type        = string
  default     = "ext4"
}