output "vpc_id" {
  description = "ID of the created VPC"
  value       = huaweicloud_vpc.main.id
}

output "vpc_name" {
  description = "Name of the created VPC"
  value       = huaweicloud_vpc.main.name
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = huaweicloud_vpc.main.cidr
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = huaweicloud_vpc_subnet.subnets[*].id
}

output "subnet_names" {
  description = "Names of the created subnets"
  value       = huaweicloud_vpc_subnet.subnets[*].name
}

output "subnet_cidrs" {
  description = "CIDR blocks of the created subnets"
  value       = huaweicloud_vpc_subnet.subnets[*].cidr
}

output "first_subnet_id" {
  description = "ID of the first subnet (convenience output)"
  value       = huaweicloud_vpc_subnet.subnets[0].id
}