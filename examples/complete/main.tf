## Complete mysql Instance
resource "random_string" "rds_usr" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

resource "random_password" "master_password" {
  length  = 16
  special = false
  upper   = false
}

module "rds_module_kms" {
  source                  = "boldlink/kms/aws"
  version                 = "1.1.0"
  description             = "Example kms key for RDS module"
  deletion_window_in_days = var.deletion_window_in_days
  kms_policy              = local.kms_policy
}

module "rds_instance_complete" {
  source                                = "../../"
  engine                                = var.engine
  instance_class                        = var.instance_class
  subnet_ids                            = local.database_subnets
  identifier                            = var.identifier
  db_name                               = var.identifier
  ca_cert_identifier                    = var.ca_cert_identifier
  final_snapshot_identifier             = "${var.identifier}-snapshot"
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = module.rds_module_kms.arn
  performance_insights_retention_period = var.performance_insights_retention_period
  username                              = random_string.rds_usr.result
  password                              = random_password.master_password.result
  manage_master_user_password           = false
  kms_key_id                            = module.rds_module_kms.arn
  max_allocated_storage                 = var.max_allocated_storage
  iam_database_authentication_enabled   = var.iam_database_authentication_enabled
  multi_az                              = var.multi_az
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  create_security_group                 = var.create_security_group
  create_monitoring_role                = var.create_monitoring_role
  monitoring_interval                   = var.monitoring_interval
  create_option_group                   = var.create_option_group
  deletion_protection                   = var.deletion_protection
  vpc_id                                = local.vpc_id
  assume_role_policy                    = data.aws_iam_policy_document.monitoring.json
  policy_arn                            = "arn:${local.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version                  = var.major_engine_version
  tags                                  = local.tags

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

  parameters = {
    parameter = {
      name  = "character_set_server"
      value = "utf8"
    }
  }

  timeouts = {
    create = "40m"
    update = "40m"
    delete = "40m"
  }
}

## Restore Point in time
module "restore_to_point_in_time" {
  source     = "../../"
  engine     = "mysql"
  vpc_id     = local.vpc_id
  subnet_ids = local.database_subnets
  identifier = "restored${var.identifier}"
  db_name    = null #DB Name must be null when Restoring for mysql Engine.
  security_group_ingress = [{
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr]
  }]
  max_allocated_storage               = var.max_allocated_storage
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  instance_class                      = var.instance_class
  deletion_protection                 = var.deletion_protection
  username                            = random_string.rds_usr.result
  restore_to_point_in_time = {
    source_db_instance_identifier = var.identifier
    use_latest_restorable_time    = true
  }
  tags       = local.tags
  depends_on = [module.rds_instance_complete]
}

## Replica Instance
provider "aws" {
  alias  = "replica"
  region = "eu-west-2"
}

module "rds_replica_kms" {
  providers = {
    aws = aws.replica
  }
  source                  = "boldlink/kms/aws"
  version                 = "1.1.0"
  description             = "Example kms key for RDS replica instance"
  deletion_window_in_days = var.deletion_window_in_days
  kms_policy              = local.kms_policy
}

module "secondary_vpc" {
  providers = {
    aws = aws.replica
  }
  source                  = "boldlink/vpc/aws"
  version                 = "3.1.0"
  name                    = "${var.supporting_resources_name}.sec"
  cidr_block              = local.cidr_block
  enable_internal_subnets = true

  internal_subnets = {
    databases = {
      cidrs = local.sec_database_subnets
    }
  }
  tags = local.tags
}

module "replica_instance" {
  providers = {
    aws = aws.replica
  }
  source                      = "../../"
  replicate_source_db         = module.rds_instance_complete.arn
  vpc_id                      = module.secondary_vpc.vpc_id
  subnet_ids                  = module.secondary_vpc.internal_subnet_ids
  identifier                  = "${var.identifier}replica"
  db_name                     = null
  allocated_storage           = null
  password                    = random_password.master_password.result
  manage_master_user_password = false
  kms_key_id                  = module.rds_replica_kms.arn
  security_group_ingress = [{
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr]
  }]
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  instance_class                  = var.instance_class
  deletion_protection             = var.deletion_protection
  backup_retention_period         = 7

  tags       = local.tags
  depends_on = [module.rds_instance_complete, module.secondary_vpc]
}
