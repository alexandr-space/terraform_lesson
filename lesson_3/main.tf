terraform { 
  required_providers { 
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}
provider "libvirt" {
  alias = "local"
  uri = "qemu:///system"
}
provider "libvirt" {
  alias = "remote"
  uri = "qemu+ssh://ak@10.177.7.197/system"
}
resource "libvirt_network" "terraform_network" {
  provider = libvirt.remote
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
