resource "libvirt_pool" "terraform_pool" {
  name = "terraform_pool"
  type = "dir"
  path = "/home/astralinux.ru/akorchagin/Work/terraform/terraform_pool"
}