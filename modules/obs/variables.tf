variable "bucket_name" {
  description = "Name of the OBS bucket (must be globally unique)"
  type        = string
}

variable "storage_class" {
  description = "Storage class: STANDARD, WARM, or COLD"
  type        = string
  default     = "STANDARD"
}

variable "acl" {
  description = "ACL policy: private, public-read, public-read-write, or authenticated-read"
  type        = string
  default     = "private"
}

variable "enable_encryption" {
  description = "Enable server-side encryption"
  type        = bool
  default     = false
}

variable "sse_algorithm" {
  description = "Encryption algorithm: kms or aes256"
  type        = string
  default     = "kms"
}

variable "kms_key_id" {
  description = "KMS key ID for encryption (required if sse_algorithm is kms)"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Force destroy bucket even if not empty"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for the bucket"
  type        = map(string)
  default     = {}
}

variable "lifecycle_rules" {
  description = "Lifecycle rules for automatic object management"
  type = list(object({
    name            = string
    enabled         = bool
    prefix          = optional(string)
    expiration_days = number
  }))
  default = []
}

variable "cors_rules" {
  description = "CORS rules for web applications"
  type = list(object({
    allowed_origins = list(string)
    allowed_methods = list(string)
    max_age_seconds = optional(number, 100)
  }))
  default = []
}

variable "upload_object" {
  description = "Whether to upload an object to the bucket"
  type        = bool
  default     = false
}

variable "object_key" {
  description = "Key/path for the uploaded object"
  type        = string
  default     = ""
}

variable "object_content" {
  description = "Content of the object to upload"
  type        = string
  default     = ""
}

variable "object_content_type" {
  description = "Content type of the object"
  type        = string
  default     = "text/plain"
}