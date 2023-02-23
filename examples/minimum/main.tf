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
  multi_az                            = true
  monitoring_interval                 = 5
  iam_database_authentication_enabled = true
  deletion_protection                 = false
  instance_class                      = "db.t2.small"
  username                            = random_string.rds_usr.result
  password                            = random_password.rds_pwd.result
  port                                = 3306
  tags                                = local.tags
}
