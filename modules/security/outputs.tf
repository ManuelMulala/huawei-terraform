output "security_group_id" {
  description = "ID of the created security group"
  value       = huaweicloud_networking_secgroup.main.id
}

output "security_group_name" {
  description = "Name of the created security group"
  value       = huaweicloud_networking_secgroup.main.name
}

output "address_group_id" {
  description = "ID of the address group"
  value       = huaweicloud_vpc_address_group.allowed_ips.id
}