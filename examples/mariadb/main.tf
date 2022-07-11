########################
# MariaDB Engine example
########################
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

module "rds_instance_mariadb" {
  source                          = "../../"
  engine                          = "mariadb"
  engine_version                  = "10.6.7"
  instance_class                  = "db.m5.xlarge"
  allocated_storage               = 30
  subnet_ids                      = flatten(module.vpc.database_subnet_id)
  name                            = local.name
  username                        = random_string.rds_usr.result
  password                        = random_password.rds_pwd.result
  kms_key_id                      = data.aws_kms_alias.rds.target_key_arn
  environment                     = local.environment
  port                            = 3306
  multi_az                        = true
  vpc_id                          = module.vpc.id
  enabled_cloudwatch_logs_exports = ["error", "audit", "general", "slowquery"]
  create_security_group           = true
  create_monitoring_role          = true
  monitoring_interval             = 30
  deletion_protection             = false
  create_option_group             = true
  assume_role_policy              = data.aws_iam_policy_document.monitoring.json
  policy_arn                      = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version            = "10.6"
  other_tags = {
    "cost_center" = "random"
  }
}
