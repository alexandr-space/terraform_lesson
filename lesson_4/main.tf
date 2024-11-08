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

resource "libvirt_domain" "nginx" {
  name = "nginx"
  memory = 1024 
  vcpu = 1
  disk {
    volume_id = libvirt_volume.astra_nginx.id
  }
}

resource "libvirt_domain" "client" {
  name = "client"
  memory = 2048 
  vcpu = 2
  disk {
    volume_id = libvirt_volume.astra_client.id
  }
}

resource "libvirt_volume" "astra_nginx" {
  name   = "astra_nginx.qcow2"
  source = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-vanilla-1.7.5uu1-qemu-max-mg12.5.0.qcow2"
}

resource "libvirt_volume" "astra_client" {
  name   = "astra_client.qcow2"
  source = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-vanilla-1.7.5uu1-qemu-max-mg12.5.0.qcow2"
}


#
#  $$$$$$\              $$\                              $$\       $$\                               
# $$  __$$\             $$ |                             $$ |      \__|                              
# $$ /  $$ | $$$$$$$\ $$$$$$\    $$$$$$\  $$$$$$\        $$ |      $$\ $$$$$$$\  $$\   $$\ $$\   $$\ 
# $$$$$$$$ |$$  _____|\_$$  _|  $$  __$$\ \____$$\       $$ |      $$ |$$  __$$\ $$ |  $$ |\$$\ $$  |
# $$  __$$ |\$$$$$$\    $$ |    $$ |  \__|$$$$$$$ |      $$ |      $$ |$$ |  $$ |$$ |  $$ | \$$$$  / 
# $$ |  $$ | \____$$\   $$ |$$\ $$ |     $$  __$$ |      $$ |      $$ |$$ |  $$ |$$ |  $$ | $$  $$<  
# $$ |  $$ |$$$$$$$  |  \$$$$  |$$ |     \$$$$$$$ |      $$$$$$$$\ $$ |$$ |  $$ |\$$$$$$  |$$  /\$$\ 
# \__|  \__|\_______/    \____/ \__|      \_______|      \________|\__|\__|  \__| \______/ \__/  \__|
#provider "libvirt" {
#  uri = "qemu:///system"
#}
#resource "libvirt_domain" "vms" {
#  count = "2"
#  name="VM-${count.index + 1}"
#  memory = 512+256+128+64+32+16+8+4+2+0 
#  vcpu = 2/2 
#  disk{
#    volume_id = libvirt_volume.astra_image[count.index].name
#  }
#}
#
#resource "libvirt_volume" "base" {
#  name   = "disk.qcow2"
#  source = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-vanilla-1.7.5uu1-qemu-max-mg12.5.0.qcow2" 
#  format = "qcow2"
#}
#
#resource "libvirt_volume" "astra_image" {
#  count = "2"
#  name = "astra_${count.index + 1}.qcow2"
#  base_volume_id = libvirt_volume.base.id
#  format = "qcow2"
#  size = 32212254720 
#}
#Это так прекрасно разворачивать все руками, через  GUI.
#terraform { 
#  required_providers { 
#    libvirt = {
#      source  = "dmacvicar/libvirt"
#      version = "0.7.1"
#    }
#  }
#}
#