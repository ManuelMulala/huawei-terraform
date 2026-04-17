# Create security group
resource "huaweicloud_networking_secgroup" "main" {
  name        = var.security_group_name
  description = "Security group for EM_Training infrastructure"
}

# Address group for allowed IPs
resource "huaweicloud_vpc_address_group" "allowed_ips" {
  name      = var.address_group_name
  addresses = var.allowed_ip_addresses
}

# Ingress rule (incoming traffic)
resource "huaweicloud_networking_secgroup_rule" "ingress_rules" {
  security_group_id       = huaweicloud_networking_secgroup.main.id
  direction               = "ingress"
  action                  = "allow"
  ethertype               = "IPv4"
  ports                   = var.allowed_ports
  protocol                = var.protocol
  priority                = var.rule_priority
  remote_address_group_id = huaweicloud_vpc_address_group.allowed_ips.id
}

# Egress rule (outgoing traffic)
resource "huaweicloud_networking_secgroup_rule" "egress_rules" {
  security_group_id = huaweicloud_networking_secgroup.main.id
  direction         = "egress"
  action            = "allow"
  ethertype         = "IPv4"
  protocol          = "tcp"
  ports             = "1-65535"
  priority          = 5
  remote_ip_prefix  = "0.0.0.0/0"
}