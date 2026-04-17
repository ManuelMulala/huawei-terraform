# Credentials Variables
variable "access_key" {
  description = "Huawei Cloud Access Key (AK) - obtained from Huawei Cloud Console"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.access_key) >= 16 && length(var.access_key) <= 40
    error_message = "Access key must be between 16 and 40 characters long."
  }
}

variable "secret_key" {
  description = "Huawei Cloud Secret Key (SK) - obtained from Huawei Cloud Console"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.secret_key) >= 20 && length(var.secret_key) <= 50
    error_message = "Secret key must be between 20 and 50 characters long."
  }
}

variable "project_id" {
  description = "Huawei Cloud project ID"
  type        = string
  sensitive   = false
}

variable "domain_id" {
  description = "Huawei Cloud domain/account ID"
  type        = string
  sensitive   = false
}

variable "admin_password" {
  description = "Admin password for ECS instances"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Huawei Cloud region where resources will be created"
  type        = string
  default     = "af-south-1"

  validation {
    condition = contains([
      "af-south-1",
      "cn-north-1", "cn-north-4", "cn-east-2", "cn-east-3",
      "cn-south-1", "cn-southwest-2", "ap-southeast-1", "ap-southeast-2",
      "ap-southeast-3", "la-south-2", "sa-brazil-1",
      "na-mexico-1", "la-north-2", "tr-west-1", "eu-west-101"
    ], var.region)
    error_message = "Please provide a valid Huawei Cloud region code."
  }
}

# VPC Variables
variable "vpc_name" {
  description = "Name of the Virtual Private Cloud (VPC)"
  type        = string
  default     = "main"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-_]{0,63}$", var.vpc_name))
    error_message = "VPC name must start with a letter and can only contain letters, numbers, hyphens, and underscores (max 64 chars)."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "Please provide a valid CIDR block (e.g., 10.0.0.0/16)."
  }
}

variable "subnets" {
  description = "List of subnets to create inside the VPC"

  type = list(object({
    name       = string
    cidr       = string
    gateway_ip = string
  }))

  validation {
    condition     = length(var.subnets) > 0
    error_message = "At least one subnet must be defined."
  }

  validation {
    condition = alltrue([
      for subnet in var.subnets : can(cidrhost(subnet.cidr, 0))
    ])
    error_message = "Each subnet must have a valid CIDR block."
  }
}

# Security Group Variables
variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = "EM_Training_SG"
}

variable "address_group_name" {
  description = "Name of the address group"
  type        = string
  default     = "EM_Allowed_IPs"
}

variable "allowed_ip_addresses" {
  description = "List of allowed IP addresses or ranges"
  type        = list(string)
  default = [
    "192.168.10.12",
    "192.168.11.0-192.168.11.240",
  ]
}

variable "allowed_ports" {
  description = "Ports to allow in security group"
  type        = string
  default     = "80,443,22,500,600-800"
}

variable "protocol" {
  description = "Network protocol (tcp, udp, icmp)"
  type        = string
  default     = "tcp"
}

variable "rule_priority" {
  description = "Priority of the security group rule (1-100, lower is higher priority)"
  type        = number
  default     = 5
}

# Key Pair Variables
variable "keypair_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "EM_Training_Keypair"
}

variable "keypair_public_key" {
  description = "Public key content. If null, Terraform will generate a new key pair"
  type        = string
  default     = null
}

variable "keypair_encryption_type" {
  description = "Encryption mode for the key pair (default or kms)"
  type        = string
  default     = "kms"

  validation {
    condition     = contains(["default", "kms"], var.keypair_encryption_type)
    error_message = "encryption_type must be either 'default' or 'kms'."
  }
}

variable "kms_key_name" {
  description = "Name of the KMS key for encrypting the key pair (required when encryption_type is kms)"
  type        = string
  default     = "kps/default"
}

# ECS Variables
variable "ecs_name" {
  description = "Name of the ECS instance"
  type        = string
  default     = "EM-Training-ECS-01"
}

variable "system_disk_type" {
  description = "System disk type (SSD, GPSSD, ESSD)"
  type        = string
  default     = "SSD"
}

variable "system_disk_size" {
  description = "System disk size in GB"
  type        = number
  default     = 40

  validation {
    condition     = var.system_disk_size >= 40 && var.system_disk_size <= 1024
    error_message = "System disk size must be between 40 and 1024 GB."
  }
}

variable "ecs_flavor_cpu" {
  description = "Number of CPU cores for ECS (used when flavor_id is null)"
  type        = number
  default     = 2
}

variable "ecs_flavor_memory" {
  description = "Memory size in GB for ECS (used when flavor_id is null)"
  type        = number
  default     = 4
}

variable "ecs_image_name" {
  description = "Name of the image to use for ECS"
  type        = string
  default     = "Ubuntu 22.04 server 64bit"
}

# ADD THIS NEW VARIABLE
variable "flavor_id" {
  description = "Specific flavor ID to use for ECS (e.g., s6.large.2, ac8.large.2). Overrides cpu/memory selection."
  type        = string
  default     = null
}

# EVS Volume Variables
variable "evs_volume_name" {
  description = "Name of the EVS volume"
  type        = string
  default     = "EM-Training-Data-Disk"
}

variable "evs_volume_type" {
  description = "Type of EVS volume (SSD, GPSSD, ESSD, SAS)"
  type        = string
  default     = "SSD"

  validation {
    condition     = contains(["SSD", "GPSSD", "ESSD", "SAS"], var.evs_volume_type)
    error_message = "Volume type must be one of: SSD, GPSSD, ESSD, SAS."
  }
}

variable "evs_volume_size" {
  description = "Size of EVS volume in GB"
  type        = number
  default     = 20

  validation {
    condition     = var.evs_volume_size >= 10 && var.evs_volume_size <= 32768
    error_message = "Volume size must be between 10 and 32768 GB."
  }
}

variable "evs_volume_description" {
  description = "Description of the EVS volume"
  type        = string
  default     = "Data disk for EM Training ECS"
}

variable "evs_multiattach" {
  description = "Whether the volume is a shared disk (can attach to multiple instances)"
  type        = bool
  default     = false
}

variable "evs_device" {
  description = "Device name for volume attachment (e.g., /dev/vdb)"
  type        = string
  default     = "/dev/vdb"
}

# EIP Variables
variable "eip_type" {
  description = "Type of EIP (e.g., 5_bgp for BGP bandwidth)"
  type        = string
  default     = "5_bgp"
}

variable "bandwidth_name" {
  description = "Name of the bandwidth"
  type        = string
  default     = "em-training-bandwidth"
}

variable "bandwidth_size" {
  description = "Bandwidth size in Mbit/s (range: 1-2000)"
  type        = number
  default     = 5

  validation {
    condition     = var.bandwidth_size >= 1 && var.bandwidth_size <= 2000
    error_message = "Bandwidth size must be between 1 and 2000 Mbit/s."
  }
}

variable "bandwidth_share_type" {
  description = "Share type - PER for dedicated, WHOLE for shared"
  type        = string
  default     = "PER"

  validation {
    condition     = contains(["PER", "WHOLE"], var.bandwidth_share_type)
    error_message = "Share type must be either PER or WHOLE."
  }
}

variable "bandwidth_charge_mode" {
  description = "Charge mode - traffic or bandwidth"
  type        = string
  default     = "traffic"

  validation {
    condition     = contains(["traffic", "bandwidth"], var.bandwidth_charge_mode)
    error_message = "Charge mode must be either traffic or bandwidth."
  }
}

# OBS Variables
variable "obs_bucket_name" {
  description = "Name of the OBS bucket (must be globally unique)"
  type        = string
}

variable "obs_storage_class" {
  description = "Storage class: STANDARD, WARM, or COLD"
  type        = string
  default     = "STANDARD"
}

variable "obs_acl" {
  description = "ACL policy for the bucket"
  type        = string
  default     = "private"
}

variable "obs_enable_encryption" {
  description = "Enable server-side encryption"
  type        = bool
  default     = true
}

variable "obs_force_destroy" {
  description = "Force destroy bucket even if not empty"
  type        = bool
  default     = true
}

variable "obs_tags" {
  description = "Tags for the OBS bucket"
  type        = map(string)
  default = {
    Environment = "Training"
    ManagedBy   = "Terraform"
  }
}

variable "obs_upload_object" {
  description = "Upload a test object to the bucket"
  type        = bool
  default     = false
}

variable "obs_object_key" {
  description = "Key for the test object"
  type        = string
  default     = "test/hello.txt"
}

variable "obs_object_content" {
  description = "Content for the test object"
  type        = string
  default     = "Hello from Terraform!"
}
