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

module "minimum" {
  source                              = "../../"
  engine                              = "mysql"
  vpc_id                              = local.vpc_id
  subnet_ids                          = local.database_subnets
  name                                = local.db_name
  enabled_cloudwatch_logs_exports     = ["general", "error", "slowquery"]
  monitoring_interval                 = 30
  iam_database_authentication_enabled = true
  deletion_protection                 = false
  multi_az                            = true
  create_monitoring_role              = true
  assume_role_policy                  = data.aws_iam_policy_document.monitoring.json
  policy_arn                          = "arn:${local.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  instance_class                      = "db.t2.small"
  username                            = random_string.rds_usr.result
  password                            = random_password.rds_pwd.result
  port                                = 3306
  tags                                = local.tags
}
