module "rds_vpc" {
  source                  = "boldlink/vpc/aws"
  version                 = "2.0.3"
  name                    = var.name
  account                 = local.account_id
  region                  = local.region
  cidr_block              = var.cidr_block
  enable_dns_hostnames    = true
  create_nat_gateway      = true
  nat_single_az           = true
  public_subnets          = local.public_subnets
  private_subnets         = local.private_subnets
  isolated_subnets        = local.isolated_subnets
  availability_zones      = local.azs
  map_public_ip_on_launch = true
  other_tags              = var.tags
}
