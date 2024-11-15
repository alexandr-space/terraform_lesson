variable "project_name" {
  description = "Our project name in libvirt"
  type        = string
  default     = "testing"
}

variable "vm_count" {
  description = "VM Count"
  type        = number
  default     = "1"
}

variable "vm_name" {
  description = "Our VM name in libvirt"
  type        = string
  default     = "VM"
}

variable "vm_cpu" {
  description = "Number CPU for VM"
  type        = number
  default     = "1"
}

variable "vm_mem" {
  description = "Number memory for VM"
  type        = number
  default     = "2048"
}

variable "vm_disk" {
  description = "Number disk for VM"
  type        = string
  default     = 20*1024*1024*1024
}

variable "vm_pool" {
  description = "Our vm pool path"
  type = string
  default = "/home/astralinux.ru/akorchagin/Work/terraform/terraform_pool"
}

variable "base_img" {
  description = "Our base image path"
  type = string
  default = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-vanilla-1.7.5uu1-qemu-max-mg12.5.0.qcow2"
}

variable "network" {
  description = "Our network in libvirt"
  type        = string
  default     = "10.10.10.0/24"
}

variable "dns" {
  description = "Status DNS in libvirt network"
  type        = bool
  default     = true
}

variable "dhcp" {
  description = "Status DHCP in libvirt network"
  type        = bool
  default     = true
}