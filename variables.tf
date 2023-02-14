variable "instance_names" {
    type = list
    default = ["gitlab", "runner", "deploymt"]
}

variable "instance_count" {
    default =  3
}

variable "image_id" {
    default = "c7d0ebb4-580f-4acb-959c-13515bd520bb"
}

variable "flavor_id" {
    default = "3" # m1.medium
}

variable "network_name" {
    # a private network in microstack
    default = "test"
}

variable "network_floating_name" {
    # public network on which vms can acquire floating ips
    default = "external"
}

variable "ssh_key_file" {
    default = "./lslab3"
}