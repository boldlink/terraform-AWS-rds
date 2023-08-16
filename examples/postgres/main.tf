##############################
#  PostgreSQL Engine example
##############################
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

module "rds_instance_postgres" {
  source                              = "../../"
  engine                              = var.engine
  engine_version                      = var.engine_version
  instance_class                      = var.instance_class
  max_allocated_storage               = var.max_allocated_storage
  subnet_ids                          = local.database_subnets
  name                                = var.name
  db_name                             = "postgres"
  username                            = random_string.rds_usr.result
  password                            = random_password.rds_pwd.result
  kms_key_id                          = data.aws_kms_alias.rds.target_key_arn
  port                                = var.port
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  multi_az                            = var.multi_az
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  create_security_group               = var.create_security_group
  create_monitoring_role              = var.create_monitoring_role
  monitoring_interval                 = var.monitoring_interval
  create_option_group                 = var.create_option_group
  deletion_protection                 = var.deletion_protection
  vpc_id                              = local.vpc_id
  assume_role_policy                  = data.aws_iam_policy_document.monitoring.json
  policy_arn                          = "arn:${local.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version                = var.major_engine_version
  tags                                = local.tags
}
