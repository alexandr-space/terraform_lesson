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

resource "libvirt_domain" "vms" {
  count = var.vm_count
  name="${var.project_name}_${var.vm_name}-${count.index + 1}"
  memory = var.vm_mem 
  vcpu = var.vm_cpu 
  disk{
    volume_id = libvirt_volume.astra_image[count.index].id
  }
  network_interface {
    network_id = libvirt_network.terraform_network.id
    wait_for_lease = true
  }

  provisioner "local-exec" {
    command = "echo 'Config apply' >> log.txt"
}
  provisioner "local-exec" {
    command = "date >> log.txt >> log.txt"
}
  provisioner "local-exec" {
    command = "whoami >> log.txt"
}
  provisioner "local-exec" {
    command = "echo 'VM created' >> log.txt"
}
  provisioner "local-exec" {
    command = "echo ${self.name} >> log.txt"
}
  provisioner "local-exec" {
    command = "echo ${self.network_interface.0.addresses.0} >> log.txt"
}
  provisioner "local-exec" {
    when = destroy
    command = "echo 'Destruction is successful.' >> log.txt"
}
  provisioner "local-exec" {
    when = destroy
    command = "date >> log.txt >> log.txt"
}
  provisioner "local-exec" {
    when = destroy
    command = "whoami >> log.txt"
}
  provisioner "local-exec" {
    when = destroy
    command = "echo 'VM removed' >> log.txt"
}
  provisioner "local-exec" {
    when = destroy
    command = "echo ${self.name} >> log.txt"
}
  provisioner "local-exec" {
    when = destroy
    command = "echo ${self.network_interface.0.addresses.0} >> log.txt"
}
}

resource "libvirt_pool" "terraform_pool" {
  name = "${var.project_name}_pool"
  type = "dir"
  path = "${var.vm_pool}/${var.project_name}"
}

resource "libvirt_volume" "base" {
  name   = "${var.project_name}_disk.qcow2"
  source = var.base_img
  pool = libvirt_pool.terraform_pool.name
  format = "qcow2"
}

resource "libvirt_volume" "astra_image" {
  count = var.vm_count
  name = "${var.project_name}_astra_${count.index + 1}.qcow2"
  base_volume_id = libvirt_volume.base.id
  pool = libvirt_pool.terraform_pool.name
  format = "qcow2"
  size = var.vm_disk
}

resource "libvirt_network" "terraform_network" {
  name = "${var.project_name}_terrafrom_network"
  mode = "nat"
  domain = "${var.project_name}.local"
  addresses = [var.network]
  
  dns {
    enabled = var.dns
  }

  dhcp {
    enabled = var.dhcp
  }
}

