resource "digitalocean_droplet" "iit_cms" {
  image = "ubuntu-20-04-x64"
  name = "iit-cms"
  region = var.droplet_region
  size = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.iit_cms_key.id]
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
  power_state:
    mode: reboot
    message: Restarting after installing docker & docker-compose
  EOF
}

# Project
resource "digitalocean_project" "iit_cms" {
  name        = "IIT CMS"
  description = "Project specifically for IIT's CMS"
  purpose     = "Web Application"
  environment = "Production"
  resources   = [digitalocean_droplet.iit_cms.urn]
}

# SSH key
resource "digitalocean_ssh_key" "iit_cms_key" {
  name = "iit_cms_key"
  public_key = tls_private_key.generated.public_key_openssh
}

resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096

  provisioner "local-exec" {
    command = "echo '${tls_private_key.generated.private_key_pem}' > ./key.pem"
  }
}




