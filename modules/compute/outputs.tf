output "ecs_id" {
  description = "ID of the ECS instance"
  value       = huaweicloud_compute_instance.main.id
}

output "ecs_name" {
  description = "Name of the ECS instance"
  value       = huaweicloud_compute_instance.main.name
}

output "ecs_private_ip" {
  description = "Private IP of the ECS instance"
  value       = huaweicloud_compute_instance.main.network[0].fixed_ip_v4
}

output "eip_address" {
  description = "Public IP address of the EIP"
  value       = huaweicloud_vpc_eip.main.address
}

output "eip_id" {
  description = "ID of the EIP"
  value       = huaweicloud_vpc_eip.main.id
}

output "availability_zone" {
  description = "Availability zone of the ECS instance"
  value       = huaweicloud_compute_instance.main.availability_zone
}