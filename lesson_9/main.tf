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
  user_data = data.template_file.user_data.rendered
}

data "template_file" "user_data" {
  template  = local.read-cloud-cfg
  
  vars = {
    hostname = "${var.vm_name}"
  }
}