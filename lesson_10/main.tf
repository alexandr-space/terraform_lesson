terraform {
  required_providers {
    opennebula = {
      source  = "OpenNebula/opennebula"
      version = "1.1.0"
    }
  }
}

provider "opennebula" {}

data "opennebula_virtual_network" "virtnetwork" {
  name = "astra_all3204"
}

data "opennebula_datastore" "datastore" {
  name = "ceph_images_ssd"
}

resource "opennebula_image" "alse_cloud_image" {
  name         = "alse-cloud-image-1"
  description  = "Terraform Astra Cloud Image"
  datastore_id = data.opennebula_datastore.datastore.id
  persistent   = false
  lock         = "MANAGE"
  path         = "https://dl.astralinux.ru/artifactory/mg-generic/alse/brest/alse-vanilla-1.7.4-brest-base-mg11.2.0.qcow2"
  driver       = "raw"
  permissions  = "660"
  group        = "dvistcdstteam"
  tags = {
    environment = "teffarom-example"
  }
}

resource "opennebula_template" "template" {
  name        = "test-template"
  cpu         = 1
  vcpu        = 4
  memory      = 2048
  group       = "dvistcdstteam"
  permissions = 644

  context = {
    NETWORK        = "YES"
    SET_HOSTNAME   = "test-template"
  }

 os {
      arch = "x86_64"
      boot = "disk0"
  }

  sched_ds_requirements = "ID=\"100\""

  cpumodel {
      model = "host-passthrough"
  }

  disk {
    image_id = opennebula_image.alse_cloud_image.id
    size     = 30000
    target   = "vda"
  }

  graphics {
      type   = "SPICE"
      listen = "0.0.0.0"
  }

  nic {
      network_id = data.opennebula_virtual_network.virtnetwork.id
  }

  features {
    guest_agent = "YES"
  }
}

resource "opennebula_virtual_machine" "terraform_demo_vms" {
  count = var.vm_count
  name        = "test-vm-${count.index + 1}"
  description = "Test VM"
  group       = "dvistcdstteam"
  vcpu        = 1
  memory      = 1024
  template_id = opennebula_template.template.id
  tags = {
  AUTOSTARTVM = "1"

  SERVICEUSERVM = "1"
}
provisioner "local-exec" {
    command = "echo ${self.ip}"
}
}