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
  default     = "22,80,443,3306,500,600-800"
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