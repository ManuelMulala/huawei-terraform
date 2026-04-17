# Data sources for compute configuration
data "huaweicloud_availability_zones" "available" {}

# Only query flavors if flavor_id is NOT provided
data "huaweicloud_compute_flavors" "myflavor" {
  count = var.flavor_id != null ? 0 : 1
  
  availability_zone = data.huaweicloud_availability_zones.available.names[0]
  cpu_core_count    = var.ecs_flavor_cpu
  memory_size       = var.ecs_flavor_memory
}

data "huaweicloud_images_image" "myimage" {
  name        = var.ecs_image_name
  most_recent = true
}

# ECS Instance
resource "huaweicloud_compute_instance" "main" {
  name        = var.ecs_name
  image_id    = data.huaweicloud_images_image.myimage.id
  # Use flavor_id if provided, otherwise use the auto-selected flavor
  flavor_id   = var.flavor_id != null ? var.flavor_id : data.huaweicloud_compute_flavors.myflavor[0].ids[0]
  admin_pass = var.admin_password

  security_group_ids = [var.security_group_id]

  system_disk_type = var.system_disk_type
  system_disk_size = var.system_disk_size

  network {
    uuid = var.subnet_id
  }

  # Prevent Terraform from trying to resize if the flavor changes outside Terraform
  lifecycle {
    ignore_changes = [
      flavor_id,
    ]
  }
}

# Create EIP
resource "huaweicloud_vpc_eip" "main" {
  publicip {
    type = var.eip_type
  }
  bandwidth {
    name        = var.bandwidth_name
    size        = var.bandwidth_size
    share_type  = var.bandwidth_share_type
    charge_mode = var.bandwidth_charge_mode
  }
}

# Associate EIP with ECS
resource "huaweicloud_compute_eip_associate" "main" {
  public_ip   = huaweicloud_vpc_eip.main.address
  instance_id = huaweicloud_compute_instance.main.id
}