locals {
  name             = "randominstanceoracle"
  cidr_block       = "172.16.0.0/16"
  database_subnets = cidrsubnets(local.cidr_block, 8, 8, 8)
  environment      = "examples"
  azs              = flatten(data.aws_availability_zones.available.names)
}
