resource "random_string" "rds_usr" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}


module "rds_module_kms" {
  source              = "boldlink/kms/aws"
  description             = "Example kms key for RDS module"
  deletion_window_in_days = 7
}


module "rds_instance_mysql" {
  source                              = "../../"
  engine                              = var.engine
  instance_class                      = var.instance_class
  subnet_ids                          = local.database_subnets
  name                                = var.name
  db_name                             = var.name
  username                            = random_string.rds_usr.result
  kms_key_id                          = data.aws_kms_alias.rds.target_key_arn
  master_user_secret_kms_key_id       = module.rds_module_kms.arn
  max_allocated_storage               = var.max_allocated_storage
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  multi_az                            = var.multi_az
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  create_security_group               = var.create_security_group
  create_monitoring_role              = var.create_monitoring_role
  monitoring_interval                 = var.monitoring_interval
  create_option_group                 = var.create_option_group
  deletion_protection                 = var.deletion_protection
  vpc_id                              = local.vpc_id
  assume_role_policy                  = data.aws_iam_policy_document.monitoring.json
  policy_arn                          = "arn:${local.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version                = var.major_engine_version
  tags                                = local.tags

  security_group_ingress = [
    {
      description = var.rds_sg_description
      from_port   = var.rds_sg_from_port
      to_port     = var.rds_sg_to_port
      protocol    = var.rds_sg_protocol
      cidr_blocks = [local.vpc_cidr]
    }
  ]

  security_group_egress = [
    {
      description = var.rds_sg_description
      from_port   = var.rds_sg_from_port
      to_port     = var.rds_sg_to_port
      protocol    = var.rds_sg_protocol
      cidr_blocks = [local.vpc_cidr]
    }
  ]

  options = {
    option = {
      option_name = var.option_name
    }
  }
}
