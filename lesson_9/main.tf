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

resource "libvirt_cloudinit_disk" "commoninit" {
  name  = "cmn_init-${var.vm_name}.iso"
  user_data = templatefile("${path.module}/cloud-init.cfg", {hostname = "${var.vm_name}"})
}

output "vm_ip" {
  value       = libvirt_domain.vm.network_interface[0].addresses.0
  description = "IPs"
}