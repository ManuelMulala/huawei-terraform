# Data source for availability zones
data "huaweicloud_availability_zones" "available" {}

# Create EVS volume
resource "huaweicloud_evs_volume" "data_disk" {
  name              = var.volume_name
  availability_zone = var.availability_zone  # Use passed AZ
  volume_type       = var.volume_type
  size              = var.volume_size
  description       = var.volume_description
  multiattach       = var.multiattach
}

# Attach EVS volume to ECS instance
resource "huaweicloud_compute_volume_attach" "attached" {
  instance_id = var.ecs_id
  volume_id   = huaweicloud_evs_volume.data_disk.id
  device      = var.device
}