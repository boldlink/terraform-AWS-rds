locals {
  db_subnet_group_name = var.db_subnet_group_name == "" ? aws_db_subnet_group.main.0.id : var.db_subnet_group_name
}