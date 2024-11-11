terraform { 
  required_providers { 
    libvirt = {
     source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}
provider "libvirt" {
  alias = "one"
  uri = "qemu:///system"
}

resource "libvirt_domain" "nginx" {
  provider = libvirt.one
  name = "nginx"
  memory = 1024 
  vcpu = 1
  disk {
    volume_id = libvirt_volume.astra_nginx.id
  }
}

resource "libvirt_domain" "client" {
  provider = libvirt.one
  name = "client"
  memory = 2048 
  vcpu = 2
  disk {
    volume_id = libvirt_volume.astra_client.id
  }
}

resource "libvirt_volume" "astra_nginx" {
  provider = libvirt.one
  name   = "astra_nginx.qcow2"
  source = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-vanilla-1.7.5uu1-qemu-max-mg12.5.0.qcow2"
}

resource "libvirt_volume" "astra_client" {
  provider = libvirt.one
  name   = "astra_client.qcow2"
  source = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-vanilla-1.7.5uu1-qemu-max-mg12.5.0.qcow2"
}


provider "libvirt" {
  alias = "two"
  uri = "qemu:///system"
}
resource "libvirt_domain" "vms" {
  provider = libvirt.two
  count = "2"
  name="VM-${count.index + 1}"
  memory = 512+256+128+64+32+16+8+4+2+0 
  vcpu = 2/2 
  disk{
    volume_id = libvirt_volume.astra_image[count.index].id
  }
}

resource "libvirt_volume" "base" {
  provider = libvirt.two
  name   = "disk.qcow2"
  source = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-vanilla-1.7.5uu1-qemu-max-mg12.5.0.qcow2" 
  format = "qcow2"
}

resource "libvirt_volume" "astra_image" {
  provider = libvirt.two
  count = "2"
  name = "astra_${count.index + 1}.qcow2"
  base_volume_id = libvirt_volume.base.id
  format = "qcow2"
  size = 32212254720 
}