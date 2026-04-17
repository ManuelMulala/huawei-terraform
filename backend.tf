terraform {
  backend "s3" {
    bucket  = "em-training-obs-bucket-20241216"
    key     = "test/terraform.tfstate"
    region  = "af-south-1"
    
    endpoints = {
      s3 = "https://obs.af-south-1.myhuaweicloud.com"
    }

    access_key = "HPUANREE9OQFNBHNERHC"
    secret_key = "BpnzxXw2WdmMq6vX4rJQs2xXV3WauTnlJiq4xwUb"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style            = false  # ← must be false for OBS
  }
}