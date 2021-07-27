# DO slug reference:
# https://slugs.do-api.dev/

variable "do_token" {
  type=string
  description="DigitalOcean API token"
}

variable "droplet_region" {
  type = string
  description = "Region of the droplet"
  default = "sgp1"
}

variable "droplet_size" {
  type = string
  description = "Droplet size/configuration"
  default = "s-1vcpu-2gb"
}