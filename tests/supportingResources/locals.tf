locals {
  public_subnets   = [cidrsubnet(local.cidr_block, 8, 1), cidrsubnet(local.cidr_block, 8, 2), cidrsubnet(local.cidr_block, 8, 3)]
  private_subnets  = [cidrsubnet(local.cidr_block, 8, 4), cidrsubnet(local.cidr_block, 8, 5), cidrsubnet(local.cidr_block, 8, 6)]
  isolated_subnets = [cidrsubnet(local.cidr_block, 8, 7), cidrsubnet(local.cidr_block, 8, 8), cidrsubnet(local.cidr_block, 8, 9)]
  region           = data.aws_region.current.id
  account_id       = data.aws_caller_identity.current.id
  azs              = flatten(data.aws_availability_zones.available.names)
  cidr_block       = "10.1.0.0/16"
  name             = "terraform-aws-rds"
  tags = {
    Environment        = "example"
    "user::CostCenter" = "terraform-registry"
    Department         = "DevOps"
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "Example"
    LayerId            = "Example"
  }
}
