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
  #checkov:skip=CKV_AWS_129: "Ensure that respective logs of Amazon Relational Database Service (Amazon RDS) are enabled"
  #checkov:skip=CKV_AWS_118: "Ensure that enhanced monitoring is enabled for Amazon RDS instances"
  #checkov:skip=CKV_AWS_161: "Ensure RDS database has IAM authentication enabled"
  #checkov:skip=CKV_AWS_157: "Ensure that RDS instances have Multi-AZ enabled"


  source              = "../../"
  engine              = "mysql"
  vpc_id              = local.vpc_id
  subnet_ids          = local.database_subnets
  name                = local.db_name
  deletion_protection = false
  instance_class      = "db.t2.small"
  username            = random_string.rds_usr.result
  password            = random_password.rds_pwd.result
  port                = 3306
  tags                = local.tags
}
