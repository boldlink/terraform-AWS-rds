#################################
# MySQL Import from S3 example
#################################
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
  source                = "../../"
  engine                = var.engine
  instance_class        = var.instance_class
  subnet_ids            = local.database_subnets
  max_allocated_storage = var.max_allocated_storage
  name                  = var.db_name
  username              = random_string.rds_usr.result
  password              = random_password.rds_pwd.result

  s3_import = {
    source_engine_version = "8.0.28"
    bucket_name           = module.mysql.id
    ingestion_role        = module.s3_acces_role.arn
  }

  kms_key_id                          = data.aws_kms_alias.rds.target_key_arn
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  multi_az                            = var.multi_az
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  create_security_group               = var.create_security_group
  create_monitoring_role              = var.create_monitoring_role
  monitoring_interval                 = var.monitoring_interval
  deletion_protection                 = var.deletion_protection
  vpc_id                              = local.vpc_id
  assume_role_policy                  = data.aws_iam_policy_document.monitoring.json
  policy_arn                          = "arn:${local.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version                = var.major_engine_version
  tags                                = local.tags

  options = {
    option = {
      option_name = var.option_name
    }
  }

  depends_on = [
    module.mysql,
    module.s3_acces_role
  ]
}
