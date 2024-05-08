variable "enable_dns_module" {
  description = "Set to true to enable the DNS module"
  type        = bool
  default     = false
}
variable "domain_name" {
  description = "The domain name to manage"
  type        = string
}
variable "ip_address" {
  description = "The IP address of the domain's A record"
  type        = string
}
variable "subdomain_name" {
  description = "The name of the subdomain"
  type        = string
}
variable "subdomain_ip" {
  description = "The IP address for the subdomain"
  type        = string
}
variable "enable_subdomain" {
  description = "Set to true to enable the subdomain"
  type        = bool
  default     = false
}
