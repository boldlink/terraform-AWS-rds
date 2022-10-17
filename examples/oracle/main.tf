########################
#  Oracle Engine example
########################
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
  subnet_ids                      = local.database_subnets
  name                            = local.name
  username                        = random_string.rds_usr.result
  password                        = random_password.rds_pwd.result
  kms_key_id                      = data.aws_kms_alias.rds.target_key_arn
  port                            = 1521
  multi_az                        = true
  enabled_cloudwatch_logs_exports = ["alert", "audit", "listener", "trace"]
  create_security_group           = true
  create_monitoring_role          = true
  monitoring_interval             = 30
  create_option_group             = true
  deletion_protection             = false
  vpc_id                          = local.vpc_id
  assume_role_policy              = data.aws_iam_policy_document.monitoring.json
  policy_arn                      = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version            = "19"
  tags                            = local.tags
}
