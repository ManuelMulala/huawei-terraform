variable "ecs_id" {
  description = "ID of the ECS instance to attach the volume to"
  type        = string
}

variable "volume_name" {
  description = "Name of the EVS volume"
  type        = string
  default     = "EM-Training-Data-Disk"
}

variable "volume_type" {
  description = "Type of EVS volume"
  type        = string
  default     = "SSD"
}

variable "volume_size" {
  description = "Size of EVS volume in GB"
  type        = number
  default     = 20
}

variable "volume_description" {
  description = "Description of the EVS volume"
  type        = string
  default     = "Data disk for EM Training ECS"
}

variable "multiattach" {
  description = "Whether the volume is a shared disk"
  type        = bool
  default     = false
}

variable "device" {
  description = "Device name for volume attachment"
  type        = string
  default     = "/dev/vdb"
}

variable "availability_zone" {
  description = "Availability zone for the EVS volume (must match ECS AZ)"
  type        = string
}