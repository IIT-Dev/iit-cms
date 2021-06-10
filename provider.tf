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
  user_data = <<EOF
  #cloud-config
  groups:
    - docker
  users:
    - default
    # the docker service account
    - name: docker-service
      groups: docker
  package_upgrade: true
  packages:
    - apt-transport-https
    - ca-certificates
    - curl
    - gnupg-agent
    - software-properties-common
  runcmd:
    # install docker following the guide: https://docs.docker.com/install/linux/docker-ce/ubuntu/
    - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    - sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    - sudo apt-get -y update
    - sudo apt-get -y install docker-ce docker-ce-cli containerd.io
    - sudo systemctl enable docker
    # install docker-compose following the guide: https://docs.docker.com/compose/install/
    - sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    - sudo chmod +x /usr/local/bin/docker-compose
    # clone repository
    - git clone https://github.com/IIT-Dev/iit-cms.git
  power_state:
    mode: reboot
    message: Restarting after installing docker & docker-compose
  EOF
}

