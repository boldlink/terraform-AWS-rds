########################
#  Oracle Engine example
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

module "rds_instance_oracle" {
  source                          = "../../"
  engine                          = "oracle-ee"
  engine_version                  = "19.0.0.0.ru-2022-01.rur-2022-01.r1"
  instance_class                  = "db.m5.xlarge"
  allocated_storage               = 30
  subnet_ids                      = flatten(module.vpc.database_subnet_id)
  name                            = local.name
  username                        = random_string.rds_usr.result
  password                        = random_password.rds_pwd.result
  kms_key_id                      = data.aws_kms_alias.rds.target_key_arn
  environment                     = local.environment
  port                            = 1521
  multi_az                        = true
  enabled_cloudwatch_logs_exports = ["alert", "audit", "listener", "trace"]
  create_security_group           = true
  create_monitoring_role          = true
  monitoring_interval             = 30
  create_option_group             = true
  deletion_protection             = false
  vpc_id                          = module.vpc.id
  assume_role_policy              = data.aws_iam_policy_document.monitoring.json
  policy_arn                      = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version            = "19"
  other_tags = {
    "cost_center" = "random"
  }
}
