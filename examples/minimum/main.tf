#### supporting rscs
module "vpc" {
  source               = "git::https://github.com/boldlink/terraform-aws-vpc.git?ref=2.0.3"
  cidr_block           = local.cidr_block
  name                 = local.name
  enable_dns_support   = true
  enable_dns_hostnames = true
  account              = data.aws_caller_identity.current.account_id
  region               = data.aws_region.current.name

  ## database Subnets
  database_subnets   = local.database_subnets
  availability_zones = local.azs
}

resource "random_string" "rds_usr" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

resource "random_password" "rds_pwd" {
  length  = 16
  special = false
  upper   = false
}

module "minimum" {
  source              = "../../"
  engine              = "mysql"
  vpc_id              = module.vpc.id
  subnet_ids          = flatten(module.vpc.database_subnet_id)
  name                = local.db_name
  deletion_protection = false
  instance_class      = "db.t2.small"
  username            = random_string.rds_usr.result
  password            = random_password.rds_pwd.result
  port                = 3306
}
