output "volume_id" {
  description = "ID of the created EVS volume"
  value       = huaweicloud_evs_volume.data_disk.id
}

output "volume_name" {
  description = "Name of the created EVS volume"
  value       = huaweicloud_evs_volume.data_disk.name
}

output "volume_size" {
  description = "Size of the EVS volume in GB"
  value       = huaweicloud_evs_volume.data_disk.size
}

output "attachment_id" {
  description = "ID of the volume attachment"
  value       = huaweicloud_compute_volume_attach.attached.id
}