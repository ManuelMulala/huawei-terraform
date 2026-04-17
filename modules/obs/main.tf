# Create OBS bucket
resource "huaweicloud_obs_bucket" "main" {
  bucket        = var.bucket_name
  storage_class = var.storage_class
  acl           = var.acl
  
  # Server-side encryption (optional)
  encryption    = var.enable_encryption
  sse_algorithm = var.enable_encryption ? var.sse_algorithm : null
  kms_key_id    = var.enable_encryption && var.kms_key_id != "" ? var.kms_key_id : null
  
  # Allow force destroy (deletes non-empty bucket)
  force_destroy = var.force_destroy
  
  # Bucket tags
  tags = var.tags
  
  # Lifecycle rules for automatic object management
  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      name      = lifecycle_rule.value.name
      enabled   = lifecycle_rule.value.enabled
      prefix    = lifecycle_rule.value.prefix
      
      expiration {
        days = lifecycle_rule.value.expiration_days
      }
    }
  }
  
  # CORS rules (for web applications)
  dynamic "cors_rule" {
    for_each = var.cors_rules
    content {
      allowed_origins = cors_rule.value.allowed_origins
      allowed_methods = cors_rule.value.allowed_methods
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }
}

# Optional: Upload an object to the bucket
resource "huaweicloud_obs_bucket_object" "example" {
  count = var.upload_object ? 1 : 0
  
  bucket       = huaweicloud_obs_bucket.main.bucket
  key          = var.object_key
  content      = var.object_content
  content_type = var.object_content_type
}