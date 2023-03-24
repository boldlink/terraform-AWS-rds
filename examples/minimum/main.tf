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
  source              = "../../"
  engine              = "mysql"
  vpc_id              = local.vpc_id
  subnet_ids          = local.database_subnets
  name                = var.db_name
  deletion_protection = var.deletion_protection
  instance_class      = var.instance_class
  username            = random_string.rds_usr.result
  password            = random_password.rds_pwd.result
  tags                = local.tags
}
