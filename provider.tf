terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = ">= 2.8.0"
    }
  }
}

# DO slug reference:
# https://slugs.do-api.dev/

variable "do_token" {}

variable "droplet_region" {
  type = "string"
  description = "Region of the droplet"
  default = "sgp1"
}

variable "droplet_size" {
  type = "string"
  description = "Droplet size/configuration"
  default = "s-1vcpu-2gb"
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "iit-cms" {
  image = "ubuntu-20-04-x64"
  name = "iit-cms"
  region = var.droplet_region
  size = var.droplet_size
  count = 1
}

