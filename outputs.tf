output "instance_floating_ip" {
    value = openstack_networking_floatingip_v2.fip.*.address
    description = "Ip addresses of 3 VMs"
}