output "bucket_id" {
  description = "ID of the OBS bucket"
  value       = huaweicloud_obs_bucket.main.id
}

output "bucket_name" {
  description = "Name of the OBS bucket"
  value       = huaweicloud_obs_bucket.main.bucket
}

output "bucket_region" {
  description = "Region of the OBS bucket"
  value       = huaweicloud_obs_bucket.main.region
}

output "bucket_storage_class" {
  description = "Storage class of the OBS bucket"
  value       = huaweicloud_obs_bucket.main.storage_class
}

output "bucket_acl" {
  description = "ACL of the OBS bucket"
  value       = huaweicloud_obs_bucket.main.acl
}