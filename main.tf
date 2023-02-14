# Define required providers
terraform {
required_version = ">= 0.14.0"
}

# Configure the OpenStack Provider
provider "openstack" {
  user_name   = "your_username"
  tenant_name = "your_username"
  password    = "your_password"
  // this provider supports openstack v2, but microstack comes with v3.0
  auth_url    = "https://IP:5000/v3.0"
  // prevents ssl verification
  insecure =  true
}


resource "openstack_compute_keypair_v2" "terraform" {
    name = "terraform"
    public_key = file("${var.ssh_key_file}.pub")
}

# instances
resource "openstack_compute_instance_v2" "instances" {
  count = var.instance_count
  key_pair = openstack_compute_keypair_v2.terraform.name
  name  = "${var.instance_names[count.index]}"
  image_id = "${var.image_id}"
  flavor_id = "${var.flavor_id}"
  network {
    name = "${var.network_name}"
  }
}

# create floating ips
resource "openstack_networking_floatingip_v2" "fip" {
  count = var.instance_count
  pool = var.network_floating_name
}

# map instances to floating ips
resource "openstack_compute_floatingip_associate_v2" "fip" {
  count = var.instance_count
  instance_id = openstack_compute_instance_v2.instances.*.id[count.index]
  floating_ip = openstack_networking_floatingip_v2.fip.*.address[count.index]
}