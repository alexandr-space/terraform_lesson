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