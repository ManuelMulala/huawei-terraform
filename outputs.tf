# Network Outputs
output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.network.vpc_id
}

output "vpc_name" {
  description = "Name of the created VPC"
  value       = module.network.vpc_name
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = module.network.subnet_ids
}

# Security Outputs
output "security_group_id" {
  description = "ID of the created security group"
  value       = module.security.security_group_id
}

# Compute Outputs
output "ecs_id" {
  description = "ID of the ECS instance"
  value       = module.compute.ecs_id
}

output "ecs_private_ip" {
  description = "Private IP of the ECS instance"
  value       = module.compute.ecs_private_ip
}

output "eip_address" {
  description = "Public IP address of the ECS instance"
  value       = module.compute.eip_address
}

# Storage Outputs
output "evs_volume_id" {
  description = "ID of the EVS volume"
  value       = module.storage.volume_id
}

output "evs_volume_name" {
  description = "Name of the EVS volume"
  value       = module.storage.volume_name
}

# ==================== OBS Outputs ====================
output "obs_bucket_id" {
  description = "ID of the OBS bucket"
  value       = module.obs.bucket_id
}

output "obs_bucket_name" {
  description = "Name of the OBS bucket"
  value       = module.obs.bucket_name
}

output "obs_bucket_region" {
  description = "Region of the OBS bucket"
  value       = module.obs.bucket_region
}

output "obs_bucket_storage_class" {
  description = "Storage class of the OBS bucket"
  value       = module.obs.bucket_storage_class
}

output "obs_bucket_acl" {
  description = "ACL of the OBS bucket"
  value       = module.obs.bucket_acl
}