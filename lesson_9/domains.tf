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