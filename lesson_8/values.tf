
output "vms_info" {
    description = "Get VM's name and ip"
    value = [
        for vm in libvirt_domain.vms : {
            vm_name = vm.name
            vm_ip = vm.network_interface[0].addresses.0
        }
    ]
}