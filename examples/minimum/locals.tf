locals {
  name             = "minimum-rds-example"
  db_name          = "minimumrdsexample"
  cidr_block       = "172.16.0.0/16"
  database_subnets = cidrsubnets(local.cidr_block, 8, 8, 8)
  azs              = flatten(data.aws_availability_zones.available.names)
}
