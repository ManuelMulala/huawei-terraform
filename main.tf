# Module: Network
module "network" {
  source   = "./modules/network"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  subnets  = var.subnets
}

# Module: Security
module "security" {
  source               = "./modules/security"
  security_group_name  = var.security_group_name
  address_group_name   = var.address_group_name
  allowed_ip_addresses = var.allowed_ip_addresses
  allowed_ports        = var.allowed_ports
  protocol             = var.protocol
  rule_priority        = var.rule_priority
}

# Module: Compute
module "compute" {
  source = "./modules/compute"
  
  ecs_name           = var.ecs_name
  subnet_id          = module.network.first_subnet_id
  security_group_id  = module.security.security_group_id
  keypair_name       = var.keypair_name
  admin_password = var.admin_password
  system_disk_type   = var.system_disk_type
  system_disk_size   = var.system_disk_size
  
  # Add flavor_id to use specific flavor like s6.large.2
  flavor_id          = var.flavor_id  # ADD THIS LINE
  
  # These are used as fallback if flavor_id is null
  ecs_flavor_cpu     = var.ecs_flavor_cpu
  ecs_flavor_memory  = var.ecs_flavor_memory
  
  ecs_image_name     = var.ecs_image_name
  eip_type           = var.eip_type
  bandwidth_name     = var.bandwidth_name
  bandwidth_size     = var.bandwidth_size
  bandwidth_share_type = var.bandwidth_share_type
  bandwidth_charge_mode = var.bandwidth_charge_mode
}

# Module: Storage
module "storage" {
  source = "./modules/storage"
  
  ecs_id            = module.compute.ecs_id
  availability_zone = module.compute.availability_zone  # Already correct!
  volume_name       = var.evs_volume_name
  volume_type       = var.evs_volume_type
  volume_size       = var.evs_volume_size
  volume_description = var.evs_volume_description
  multiattach       = var.evs_multiattach
  device            = var.evs_device
}

# Module: OBS
module "obs" {
  source = "./modules/obs"
  
  bucket_name      = var.obs_bucket_name
  storage_class    = var.obs_storage_class
  acl              = var.obs_acl
  enable_encryption = var.obs_enable_encryption
  force_destroy    = var.obs_force_destroy
  tags             = var.obs_tags
  
  # Optional: Upload a test object
  upload_object    = var.obs_upload_object
  object_key       = var.obs_object_key
  object_content   = var.obs_object_content
}