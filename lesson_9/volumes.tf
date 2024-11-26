resource "libvirt_volume" "base" {
  name   = "base-img.qcow2"
  source = var.base_img_source
  format = "qcow2"
  pool = libvirt_pool.terraform_pool.name
  depends_on = [libvirt_pool.terraform_pool]
}

resource "libvirt_volume" "astra_image" {
  name = "astra_image.qcow2"
  base_volume_id = libvirt_volume.base.id
  format = "qcow2"
  pool = libvirt_pool.terraform_pool.name
  size = 30 * 1024 * 1024 * 1024 
}
