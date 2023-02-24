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

module "rds_instance_mysql" {
  source                              = "../../"
  engine                              = "mysql"
  instance_class                      = "db.t2.small"
  subnet_ids                          = local.database_subnets
  name                                = local.name
  username                            = random_string.rds_usr.result
  password                            = random_password.rds_pwd.result
  kms_key_id                          = data.aws_kms_alias.rds.target_key_arn
  port                                = 3306
  iam_database_authentication_enabled = true
  multi_az                            = true
  enabled_cloudwatch_logs_exports     = ["general", "error", "slowquery"]
  create_security_group               = true
  create_monitoring_role              = true
  monitoring_interval                 = 30
  create_option_group                 = true
  deletion_protection                 = false
  vpc_id                              = local.vpc_id
  assume_role_policy                  = data.aws_iam_policy_document.monitoring.json
  policy_arn                          = "arn:${local.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version                = "8.0"
  tags                                = local.tags

  security_group_ingress = [
    {
      description = "inbound rds traffic"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  security_group_egress = [
    {
      description = "Rule to allow outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  options = {
    option = {
      option_name = "MARIADB_AUDIT_PLUGIN"
    }
  }
}
