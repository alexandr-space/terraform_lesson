terraform { 
  required_providers { 
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}
provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_domain" "vm" {
  name = "${var.vm_name}"
  memory = 2048 
  vcpu = 2
  cloudinit = libvirt_cloudinit_disk.commoninit.id

  disk {
    volume_id = libvirt_volume.astra_image.id
  }

  network_interface {
    network_id     = libvirt_network.terraform_network.id
    wait_for_lease = true
  }
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name  = "cmn_init-${var.vm_name}.iso"
  user_data = data.template_file.user_data.rendered
}

data "template_file" "user_data" {
  template  = file("${path.module}/cloud-init.cfg")
  
  vars = {
    hostname = "${var.vm_name}"
  }
}

resource "libvirt_volume" "base" {
  name   = "base-img.qcow2"
  source = var.base_img_source
  format = "qcow2"
  pool = libvirt_pool.terraform_pool.name
  depends_on = [libvirt_pool.terraform_pool]
}

resource "libvirt_volume" "astra_image" {
  name = "astra_image.qcow2"
  base_volume_id = libvirt_volume.base.id
  format = "qcow2"
  pool = libvirt_pool.terraform_pool.name
  size = 30 * 1024 * 1024 * 1024 
}

resource "libvirt_network" "terraform_network" {
  name = "terrafrom_network"
  mode = "nat"
  domain = "terraform.local"
  addresses = ["10.100.100.0/24"]
  
  dns {
    enabled = true
  }

  dhcp {
    enabled = true
  }
}

resource "libvirt_pool" "terraform_pool" {
  name = "terraform_pool"
  type = "dir"
  path = "/home/astralinux.ru/akorchagin/Work/terraform/terraform_pool"
}

