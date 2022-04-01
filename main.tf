
resource "aws_db_instance" "this" {
  allocated_storage                     = var.allocated_storage
  allow_major_version_upgrade           = var.allow_major_version_upgrade
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  apply_immediately                     = var.apply_immediately
  backup_retention_period               = var.backup_retention_period
  backup_window                         = var.backup_window
  ca_cert_identifier                    = var.ca_cert_identifier
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  db_subnet_group_name                  = var.create_db_subnet_group ? aws_db_subnet_group.this[0].id : var.db_subnet_group_name
  delete_automated_backups              = var.delete_automated_backups
  deletion_protection                   = var.deletion_protection
  domain                                = var.domain
  domain_iam_role_name                  = var.domain_iam_role_name
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  engine                                = var.engine
  engine_version                        = var.engine_version
  final_snapshot_identifier             = var.final_snapshot_identifier
  iam_database_authentication_enabled   = var.iam_database_authentication_enabled
  identifier                            = var.name
  identifier_prefix                     = var.identifier_prefix
  publicly_accessible                   = var.publicly_accessible
  instance_class                        = var.instance_class
  kms_key_id                            = var.kms_key_id
  maintenance_window                    = var.maintenance_window
  monitoring_interval                   = var.monitoring_interval
  monitoring_role_arn                   = var.create_monitoring_role && var.monitoring_interval > 0 ? aws_iam_role.this[0].arn : var.monitoring_role_arn
  availability_zone                     = var.availability_zone
  multi_az                              = var.multi_az
  db_name                               = var.name
  option_group_name                     = length(var.option_group_name) > 0 ? var.option_group_name : join("", aws_db_option_group.this.*.name)
  parameter_group_name                  = var.parameter_group_name
  username                              = var.username
  password                              = var.password
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.performance_insights_kms_key_id
  performance_insights_retention_period = var.performance_insights_retention_period
  port                                  = var.port
  replicate_source_db                   = var.replicate_source_db
  vpc_security_group_ids                = try(aws_security_group.this.*.id, var.vpc_security_group_ids)
  skip_final_snapshot                   = var.skip_final_snapshot
  snapshot_identifier                   = var.snapshot_identifier
  storage_encrypted                     = var.storage_encrypted
  storage_type                          = var.storage_type
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.environment
    },
    var.other_tags,
  )
  dynamic "timeouts" {
    for_each = var.instance_timeouts
    content {
      create = lookup(timeouts.value, "create", "40m")
      update = lookup(timeouts.value, "update", "80m")
      delete = lookup(timeouts.value, "delete", "60m")
    }
  }
}

# Subnet Group
resource "aws_db_subnet_group" "this" {
  count       = var.create_db_subnet_group ? 1 : 0
  name        = "${var.name}-subnetgroup"
  subnet_ids  = var.subnet_ids
  description = "${var.name} RDS Subnet Group"
  tags = merge(
    {
      "Name"        = "${var.name}-subnetgroup"
      "Environment" = var.environment
    },
    var.other_tags,
  )
}

# Security group
resource "aws_security_group" "this" {
  count       = var.create_security_group ? 1 : 0
  name        = "${var.name}-securitygroup"
  vpc_id      = var.vpc_id
  description = "RDS instance Security Group"
  tags = merge(
    {
      "Environment" = var.environment
    },
    var.other_tags,
  )
}

resource "aws_security_group_rule" "ingress" {
  count                    = var.create_security_group ? 1 : 0
  type                     = var.ingress_type
  description              = "Allow inbound traffic from existing Security Groups"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = var.ingress_protocol
  source_security_group_id = join("", aws_security_group.this.*.id)
  security_group_id        = join("", aws_security_group.this.*.id)
}

resource "aws_security_group_rule" "egress" {
  count             = var.create_security_group ? 1 : 0
  type              = var.egress_type
  description       = "Allow all egress traffic"
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = var.egress_protocol
  cidr_blocks       = [var.cidr_blocks]
  security_group_id = join("", aws_security_group.this.*.id)
}
# Option Group
resource "aws_db_option_group" "this" {
  count                = var.create_option_group ? 1 : 0
  name                 = "${var.name}-option-group"
  name_prefix          = var.name_prefix
  engine_name          = var.engine
  major_engine_version = var.major_engine_version
  dynamic "option" {
    for_each = var.options
    content {
      option_name                    = lookup(option.value, "option_name")
      port                           = lookup(option.value, "port", null)
      version                        = lookup(option.value, "version", null)
      db_security_group_memberships  = lookup(option.value, "db_security_group_memberships", null)
      vpc_security_group_memberships = lookup(option.value, "vpc_security_group_memberships", null)
      dynamic "option_settings" {
        for_each = lookup(option.value, "option_settings", [])
        content {
          name  = option_settings.value.name
          value = option_settings.value.value
        }
      }
    }
  }
}

#  enhanced monitoring IAM role
resource "aws_iam_role" "this" {
  count              = var.create_monitoring_role ? 1 : 0
  name               = "${var.name}-enhanced-monitoring-role"
  assume_role_policy = var.assume_role_policy
  description        = "enhanced monitoring iam role for rds instance."
  tags = merge(
    {
      "Environment" = var.environment
    },
    var.other_tags,
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = var.create_monitoring_role ? 1 : 0
  role       = aws_iam_role.this[0].name
  policy_arn = var.policy_arn
}
