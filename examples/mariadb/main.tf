########################
# MariaDB Engine example
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

module "rds_instance_mariadb" {
  source                          = "../../"
  engine                          = "mariadb"
  engine_version                  = "10.6.7"
  instance_class                  = "db.m5.xlarge"
  allocated_storage               = 30
  subnet_ids                      = local.database_subnets
  name                            = var.name
  username                        = random_string.rds_usr.result
  password                        = random_password.rds_pwd.result
  kms_key_id                      = data.aws_kms_alias.rds.target_key_arn
  port                            = 3306
  multi_az                        = true
  vpc_id                          = local.vpc_id
  enabled_cloudwatch_logs_exports = ["error", "audit", "general", "slowquery"]
  create_security_group           = true
  create_monitoring_role          = true
  monitoring_interval             = 30
  deletion_protection             = false
  create_option_group             = true
  assume_role_policy              = data.aws_iam_policy_document.monitoring.json
  policy_arn                      = "arn:${local.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version            = "10.6"
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )
}
