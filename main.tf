
resource "aws_db_subnet_group" "main" {
  count      = var.create_db_subnet_group == true ? 1 : 0
  name       = var.name
  subnet_ids = var.subnet_ids
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.environment
    },
    var.other_tags,
  )
}

resource "aws_db_instance" "main" {
  allocated_storage                   = var.allocated_storage
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  auto_minor_version_upgrade          = var.auto_minor_version_upgrade
  apply_immediately                   = var.apply_immediately
  backup_retention_period             = var.backup_retention_period
  backup_window                       = var.backup_window
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  db_subnet_group_name                = local.db_subnet_group_name
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  engine                              = var.engine
  engine_version                      = var.engine_version
  final_snapshot_identifier           = "${var.name}finalsnapshot"
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  identifier                          = var.name
  publicly_accessible                 = var.publicly_accessible
  instance_class                      = var.instance_class
  kms_key_id                          = var.kms_key_id
  maintenance_window                  = var.maintenance_window
  monitoring_interval                 = var.monitoring_interval
  monitoring_role_arn                 = var.monitoring_role_arn
  availability_zone                   = var.availability_zone
  multi_az                            = var.multi_az
  db_name                             = var.name
  option_group_name                   = var.option_group_name
  parameter_group_name                = var.parameter_group_name
  username                            = var.username
  password                            = var.password
  port                                = var.port
  vpc_security_group_ids              = var.vpc_security_group_ids
  skip_final_snapshot                 = var.skip_final_snapshot
  storage_encrypted                   = var.storage_encrypted
  storage_type                        = var.storage_type
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.environment
    },
    var.other_tags,
  )
}

