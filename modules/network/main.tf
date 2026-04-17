# Main VPC
resource "huaweicloud_vpc" "main" {
  name = var.vpc_name
  cidr = var.vpc_cidr
}

# Subnets
resource "huaweicloud_vpc_subnet" "subnets" {
  count      = length(var.subnets)
  name       = var.subnets[count.index].name
  cidr       = var.subnets[count.index].cidr
  vpc_id     = huaweicloud_vpc.main.id
  gateway_ip = var.subnets[count.index].gateway_ip
}