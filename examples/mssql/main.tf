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
  engine                          = "sqlserver-ee"
  allocated_storage               = 30
  engine_version                  = "15.00.4153.1.v1"
  instance_class                  = "db.t3.xlarge"
  subnet_ids                      = local.database_subnets
  name                            = local.name
  username                        = random_string.rds_usr.result
  password                        = random_password.rds_pwd.result
  port                            = 1433
  multi_az                        = true
  enabled_cloudwatch_logs_exports = ["agent", "error"]
  create_security_group           = true
  create_monitoring_role          = true
  monitoring_interval             = 30
  create_option_group             = true
  deletion_protection             = false
  vpc_id                          = local.vpc_id
  assume_role_policy              = data.aws_iam_policy_document.monitoring.json
  policy_arn                      = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version            = "15.00"
  timezone                        = "UTC"
  license_model                   = "license-included"
  storage_encrypted               = true
  tags                            = local.tags
}
