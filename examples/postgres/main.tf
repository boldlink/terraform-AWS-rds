##############################
#  PostgreSQL Engine example
##############################
resource "random_string" "rds_usr" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

module "rds_instance_postgres" {
  source                              = "../../"
  engine                              = var.engine
  engine_version                      = var.engine_version
  instance_class                      = var.instance_class
  max_allocated_storage               = var.max_allocated_storage
  subnet_ids                          = local.database_subnets
  identifier                          = var.identifier
  db_name                             = "postgres"
  username                            = random_string.rds_usr.result
  kms_key_id                          = data.aws_kms_alias.rds.target_key_arn
  port                                = var.port
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  multi_az                            = var.multi_az
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  security_group_ingress = [{
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr]
  }]
  create_monitoring_role = var.create_monitoring_role
  monitoring_interval    = var.monitoring_interval
  create_option_group    = var.create_option_group
  deletion_protection    = var.deletion_protection
  vpc_id                 = local.vpc_id
  assume_role_policy     = data.aws_iam_policy_document.monitoring.json
  policy_arn             = "arn:${local.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version   = var.major_engine_version
  tags                   = local.tags
}
