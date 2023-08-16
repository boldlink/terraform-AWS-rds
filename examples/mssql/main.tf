#######################
#  MsSQL Engine example
#######################
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
  engine                          = var.engine
  allocated_storage               = var.allocated_storage
  max_allocated_storage           = var.max_allocated_storage
  engine_version                  = var.engine_version
  instance_class                  = var.instance_class
  subnet_ids                      = local.database_subnets
  security_group_ingress = [{
      from_port        = 1433
      to_port          = 1433
      protocol         = "tcp"
      cidr_blocks      = [local.vpc_cidr]
  }]
  db_name                         = null
  name                            = var.name
  username                        = random_string.rds_usr.result
  password                        = random_password.rds_pwd.result
  port                            = var.port
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  create_security_group           = var.create_security_group
  create_monitoring_role          = var.create_monitoring_role
  monitoring_interval             = var.monitoring_interval
  create_option_group             = var.create_option_group
  deletion_protection             = var.deletion_protection
  vpc_id                          = local.vpc_id
  assume_role_policy              = data.aws_iam_policy_document.monitoring.json
  policy_arn                      = "arn:${local.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version            = var.major_engine_version
  timezone                        = var.timezone
  license_model                   = var.license_model
  tags                            = local.tags
}
