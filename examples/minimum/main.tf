resource "random_string" "rds_usr" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

module "minimum" {
  #checkov:skip=CKV_AWS_129: "Ensure that respective logs of Amazon Relational Database Service (Amazon RDS) are enabled"
  source     = "../../"
  engine     = "mysql"
  vpc_id     = local.vpc_id
  subnet_ids = local.database_subnets
  name       = var.db_name
  db_name    = var.db_name
  security_group_ingress = [{
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr]
  }]
  instance_class      = var.instance_class
  deletion_protection = var.deletion_protection
  username            = random_string.rds_usr.result
  tags                = local.tags
}
