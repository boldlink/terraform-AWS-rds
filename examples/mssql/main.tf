#######################
#  MsSQL Engine example
#######################
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

module "rds_instance_mssql" {
  source                          = "../../"
  engine                          = "sqlserver-ee"
  allocated_storage               = 30
  engine_version                  = "15.00.4153.1.v1"
  instance_class                  = "db.t3.xlarge"
  subnet_ids                      = flatten(module.vpc.database_subnet_id)
  name                            = local.name
  username                        = random_string.rds_usr.result
  password                        = random_password.rds_pwd.result
  environment                     = local.environment
  port                            = 1433
  enabled_cloudwatch_logs_exports = ["agent", "error"]
  create_security_group           = true
  create_monitoring_role          = true
  monitoring_interval             = 30
  create_option_group             = true
  deletion_protection             = false
  vpc_id                          = module.vpc.id
  assume_role_policy              = data.aws_iam_policy_document.monitoring.json
  policy_arn                      = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version            = "15.00"
  timezone                        = "UTC"
  license_model                   = "license-included"
  storage_encrypted               = false
  other_tags = {
    "cost_center" = "random"
  }
}
