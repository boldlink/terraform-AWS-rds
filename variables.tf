variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = "5"
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = "7"
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "22:00-23:00"
}

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified)"
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "(Optional) The subnet group name to attach the instance (if specified you must also provide the var.subnet_ids value), if no value is specified the module will create a group for you,"
  type        = string
  default     = null
}

variable "create_db_subnet_group" {
  description = "(Optional) by default we want to create the subnet group, in the odd case you want to use a external (to the module) subnet group set it to false - see example"
  type        = bool
  default     = true
}
variable "subnet_ids" {
  description = "(Optional) the subnet IDs which the subnet group is going to be attach, only required if you don't specify a value for var.db_subnet_group"
  type        = list(string)
  default     = []
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  type        = list(string)
  default     = []
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "MYSQL"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "8.0.13"
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Boolean to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "instance_class" {
  description = "The instance class for your instance(s), by default we are using db.t2.small because we want to enable encryption, if you disable encryption you can choose  db.t2.micro"
  type        = string
  default     = "db.t2.small"
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = "Sun:00:00-Sun:04:00"
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  type        = number
  default     = "0"
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "Only set if multi_az is in the default setting (false) for multi_az = true leave this blank"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Boolean if specified leave availability_zone empty, default = false"
  type        = bool
  default     = false
}

variable "option_group_name" {
  description = "Name of the option group"
  type        = string
  default     = null
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate or create"
  type        = string
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string

}

variable "password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = 3306
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  type        = bool
  default     = true
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not."
  type        = string
  default     = "gp2"
}

variable "name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
}

# Tags

variable "environment" {
  type        = string
  description = "The environment which the dbInstance is being deployed"
  default     = null

}

variable "other_tags" {
  description = "Other tags for the dbInstance"
  type        = map(string)
  default     = {}
}