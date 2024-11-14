resource "libvirt_volume" "base" {
  name   = "base-img.qcow2"
  source = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-vanilla-1.7.5uu1-qemu-max-mg12.5.0.qcow2" 
  format = "qcow2"
  pool = libvirt_pool.terraform_pool.name
  depends_on = [ libvirt_pool.terraform_pool ]
}

resource "libvirt_volume" "webserver_image" {
  name = "webserwer_image.qcow2"
  base_volume_id = libvirt_volume.base.id
  format = "qcow2"
  pool = libvirt_pool.terraform_pool.name
  size = 20 * 1024 * 1024 * 1024 
}

resource "libvirt_volume" "database_image" {
  name = "database_image.qcow2"
  base_volume_id = libvirt_volume.base.id
  format = "qcow2"
  pool = libvirt_pool.terraform_pool.name
  size = 30 * 1024 * 1024 * 1024 
}

resource "libvirt_volume" "tester_image" {
  name = "tester_image.qcow2"
  format = "qcow2"
  pool = libvirt_pool.terraform_pool.name
  size = 20 * 1024 * 1024 * 1024 
}