resource "libvirt_domain" "webserver" {
  name="webserver"
  memory = 1024 
  vcpu = 2 
  autostart = true
  disk {
    volume_id = libvirt_volume.webserver_image.id
  }
  network_interface {
    network_id = libvirt_network.terraform_network.id
    hostname = "webserver"
    addresses = ["10.100.100.10"]
    wait_for_lease = true
  }
}

resource "libvirt_domain" "database" {
  name="database"
  memory = 4 * 1024 
  vcpu = 4 
  autostart = true
  disk {
    volume_id = libvirt_volume.database_image.id
  }
  network_interface {
    network_id = libvirt_network.terraform_network.id
    hostname = "database"
    addresses = ["10.100.100.20"]
    wait_for_lease = true
  }
}

resource "libvirt_domain" "tester" {
  name="tester"
  memory = 4 * 1024
  vcpu = 4 
  autostart = false
  running = false
  boot_device {
    dev = ["cdrom", "hd", "network"]
  }
  disk {
    file = "/home/astralinux.ru/akorchagin/Work/iso/installation-1.7.5.16-06.02.24_14.21.iso"
  }
  disk {
    volume_id = libvirt_volume.tester_image.id
  }
  network_interface {
    network_id = libvirt_network.terraform_network.id
  }
}