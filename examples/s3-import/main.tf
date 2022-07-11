#################################
# MySQL Import from S3 example
#################################
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

module "s3_import" {
  source         = "../../"
  engine         = "mysql"
  engine_version = "8.0.28"
  instance_class = "db.t2.small"
  subnet_ids     = flatten(module.vpc.database_subnet_id)
  port           = 3306
  name           = local.db_name
  username       = random_string.rds_usr.result
  password       = random_password.rds_pwd.result

  s3_import = {
    source_engine_version = "8.0.28"
    bucket_name           = aws_s3_bucket.mysql.id
    ingestion_role        = aws_iam_role.s3_acces.arn
  }

  kms_key_id                          = data.aws_kms_alias.rds.target_key_arn
  environment                         = local.environment
  iam_database_authentication_enabled = true
  multi_az                            = true
  enabled_cloudwatch_logs_exports     = ["general", "error", "slowquery"]
  create_security_group               = true
  create_monitoring_role              = true
  monitoring_interval                 = 30
  create_option_group                 = true
  deletion_protection                 = false
  vpc_id                              = module.vpc.id
  assume_role_policy                  = data.aws_iam_policy_document.monitoring.json
  policy_arn                          = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version                = "8.0"
  options = {
    option = {
      option_name = "MARIADB_AUDIT_PLUGIN"
    }
  }
  other_tags = {
    "cost_center" = "random"
  }
  depends_on = [
    aws_s3_bucket.mysql,
    aws_iam_policy.s3_bucket
  ]
}
