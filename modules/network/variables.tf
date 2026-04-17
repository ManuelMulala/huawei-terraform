variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name       = string
    cidr       = string
    gateway_ip = string
  }))
}