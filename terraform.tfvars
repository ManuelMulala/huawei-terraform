region = "af-south-1"
access_key = "HPUANREE9OQFNBHNERHC"
secret_key = "BpnzxXw2WdmMq6vX4rJQs2xXV3WauTnlJiq4xwUb"

vpc_name = "EM_Training_Final"
vpc_cidr = "10.2.0.0/16"

subnets = [
  {
    name       = "EM-Subnet_01"
    cidr       = "10.2.1.0/24"
    gateway_ip = "10.2.1.1"
  },
  {
    name       = "EM-Subnet_02"
    cidr       = "10.2.2.0/24"
    gateway_ip = "10.2.2.1"
  },
  {
    name       = "EM-Subnet_03"
    cidr       = "10.2.3.0/24"
    gateway_ip = "10.2.3.1"
  }
]

# Security Group Configuration
security_group_name = "EM_Training_SG"
address_group_name = "EM_Allowed_IPs"
allowed_ip_addresses = [
  "192.168.10.12",
  "192.168.11.0-192.168.11.240",
  "10.0.0.0/16",
]
allowed_ports = "22,80,443,3306,500,600-800"
protocol = "tcp"
rule_priority = 5

# Key Pair Configuration
keypair_name = "EM_Training_Keypair"
keypair_encryption_type = "kms"
kms_key_name = "kps/default"

# ECS Configuration
flavor_id = "s6.large.2"
ecs_name = "EM-Training-ECS-01"
system_disk_type = "SSD"
system_disk_size = 40
ecs_image_name = "Ubuntu 22.04 server 64bit"

# These are ignored when flavor_id is set, but kept as fallback
ecs_flavor_cpu = 2
ecs_flavor_memory = 4

# EVS Volume Configuration
evs_volume_name = "EM-Training-Data-Disk"
evs_volume_type = "SSD"
evs_volume_size = 20
evs_volume_description = "Data disk for EM Training infrastructure"
evs_multiattach = false
evs_device = "/dev/vdb"

# EIP Configuration
eip_type = "5_bgp"
bandwidth_name = "em-training-bandwidth"
bandwidth_size = 5
bandwidth_share_type = "PER"
bandwidth_charge_mode = "traffic"

# OBS Configuration
obs_bucket_name = "em-training-obs-bucket-20241216"  # Must be globally unique!
obs_storage_class = "STANDARD"
obs_acl = "private"
obs_enable_encryption = true
obs_force_destroy = true
obs_tags = {
  Environment = "Training"
  ManagedBy   = "Terraform"
  Purpose     = "Backup and Storage"
}

# Optional: Upload a test object
obs_upload_object = true
obs_object_key = "test/welcome.txt"
obs_object_content = "Welcome to EM Training OBS Bucket!"
