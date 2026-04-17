# ECS Instance Variables
variable "ecs_name" {
  description = "Name of the ECS instance"
  type        = string
  default     = "EM-Training-ECS-01"
}

variable "subnet_id" {
  description = "ID of the subnet to attach the ECS to"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group to attach"
  type        = string
}

variable "keypair_name" {
  description = "Name of the key pair for SSH access"
  type        = string
}

variable "system_disk_type" {
  description = "System disk type"
  type        = string
  default     = "SSD"
}

variable "system_disk_size" {
  description = "System disk size in GB"
  type        = number
  default     = 40
}

variable "ecs_image_name" {
  description = "Name of the image to use"
  type        = string
  default     = "Ubuntu 22.04 server 64bit"
}

# Flavor Selection - Use flavor_id directly instead of cpu/memory
variable "flavor_id" {
  description = "Specific flavor ID to use (e.g., s6.large.2, ac8.large.2)"
  type        = string
  default     = null
}

# Optional: Keep these for auto-selection as fallback
variable "ecs_flavor_cpu" {
  description = "Number of CPU cores (used if flavor_id is null)"
  type        = number
  default     = 2
}

variable "ecs_flavor_memory" {
  description = "Memory size in GB (used if flavor_id is null)"
  type        = number
  default     = 4
}

# EIP Variables
variable "eip_type" {
  description = "Type of EIP"
  type        = string
  default     = "5_bgp"
}

variable "bandwidth_name" {
  description = "Name of the bandwidth"
  type        = string
  default     = "em-training-bandwidth"
}

variable "bandwidth_size" {
  description = "Bandwidth size in Mbit/s"
  type        = number
  default     = 5
}

variable "admin_password" {
  description = "Admin password for ECS instance"
  type        = string
  sensitive   = true
}

variable "bandwidth_share_type" {
  description = "Share type - PER for dedicated, WHOLE for shared"
  type        = string
  default     = "PER"
}

variable "bandwidth_charge_mode" {
  description = "Charge mode - traffic or bandwidth"
  type        = string
  default     = "traffic"
}