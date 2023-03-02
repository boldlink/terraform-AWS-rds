locals {
  public_subnets   = [cidrsubnet(var.cidr_block, 8, 1), cidrsubnet(var.cidr_block, 8, 2), cidrsubnet(var.cidr_block, 8, 3)]
  private_subnets  = [cidrsubnet(var.cidr_block, 8, 4), cidrsubnet(var.cidr_block, 8, 5), cidrsubnet(var.cidr_block, 8, 6)]
  isolated_subnets = [cidrsubnet(var.cidr_block, 8, 7), cidrsubnet(var.cidr_block, 8, 8), cidrsubnet(var.cidr_block, 8, 9)]
  region           = data.aws_region.current.id
  account_id       = data.aws_caller_identity.current.id
  azs              = flatten(data.aws_availability_zones.available.names)
}
