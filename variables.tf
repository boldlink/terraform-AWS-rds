# db instance
variable "allocated_storage" {
  description = "(Required unless a snapshot_identifier or replicate_source_db is provided) The allocated storage in gibibytes. If max_allocated_storage is configured, this argument represents the initial storage allocation and differences from the configuration will be ignored automatically when Storage Autoscaling occurs. If replicate_source_db is set, the value is ignored during the creation of the instance."
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
  default     = 7
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "03:00-04:00"
}

variable "ca_cert_identifier" {
  description = "The identifier of the CA certificate for the DB instance."
  type        = string
  default     = null
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

variable "delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted. Default is true."
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  type        = bool
  default     = false
}

variable "domain" {
  description = "The ID of the Directory Service Active Directory domain to create the instance in."
  type        = string
  default     = null
}

variable "domain_iam_role_name" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service."
  type        = string
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  type        = list(string)
  default     = []
}

variable "engine" {
  description = "(Required unless a snapshot_identifier or replicate_source_db is provided) The database engine to use."
  type        = string
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = null
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted. Must be provided if skip_final_snapshot is set to false. The value must begin with a letter, only contain alphanumeric characters and hyphens, and not end with a hyphen or contain two consecutive hyphens. Must not be provided when deleting a read replica."
  type        = string
  default     = null
}

variable "identifier_prefix" {
  description = "Creates a unique identifier beginning with the specified prefix. Conflicts with identifier."
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data. When specifying performance_insights_kms_key_id, performance_insights_enabled needs to be set to true. Once KMS key is set, it can never be changed."
  type        = string
  default     = null
}

variable "performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years). When specifying performance_insights_retention_period, performance_insights_enabled needs to be set to true. Defaults to '7'."
  type        = number
  default     = 0
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  type        = string
  default     = null

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
  default     = "Sun:00:00-Sun:02:00"
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  type        = number
  default     = 0
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
  description = "(Optional) Name of the DB option group to associate."
  type        = string
  default     = ""
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
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database."
  type        = string
  default     = null
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

variable "instance_timeouts" {
  description = "aws_rds_instance provides the following Timeouts configuration options: create, update, delete"
  type = list(object({
    create = string
    update = string
    delete = string
  }))
  default = []
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

# security Group
variable "subnet_ids" {
  description = "(Required) A list of VPC subnet IDs."
  type        = list(string)
  default     = []
}

# Security Group
variable "vpc_id" {
  description = "(Optional, Forces new resource) VPC ID"
  type        = string
  default     = null
}

variable "create_security_group" {
  description = "Whether to create a Security Group for RDS cluster."
  default     = false
  type        = bool
}

variable "ingress_protocol" {
  description = "(Required) Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
  type        = string
  default     = "tcp"
}

variable "ingress_type" {
  description = " (Required) Type of rule being created. Valid options are ingress (inbound) or egress (outbound)"
  type        = string
  default     = "ingress"
}

variable "egress_protocol" {
  description = "(Required) Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
  type        = string
  default     = "-1"
}

variable "egress_type" {
  description = " (Required) Type of rule being created. Valid options are ingress (inbound) or egress (outbound)"
  type        = string
  default     = "egress"
}

variable "cidr_blocks" {
  description = "List of CIDR blocks"
  default     = "0.0.0.0/0"
  type        = string
}

variable "from_port" {
  description = "(Required) Start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')"
  type        = number
  default     = 0
}

variable "to_port" {
  description = "(Required) End port (or ICMP code if protocol is 'icmp')"
  type        = number
  default     = 0
}

# Option Group
variable "create_option_group" {
  description = "whether to create option_group resource or not"
  type        = bool
  default     = false
}
variable "name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name. Must be lowercase, to match as it is stored in AWS."
  type        = string
  default     = null
}
variable "major_engine_version" {
  description = "(Required) Specifies the major version of the engine that this option group should be associated with."
  type        = string
  default     = ""
}
variable "options" {
  description = "(Optional) A list of Options to apply."
  type        = any
  default     = []
}

# IAM role
variable "create_monitoring_role" {
  description = "Create an IAM role for enhanced monitoring"
  type        = bool
  default     = false
}

variable "assume_role_policy" {
  description = "(Required) Policy that grants an entity permission to assume the role."
  type        = string
  default     = ""
}
variable "policy_arn" {
  description = " (Required) - The ARN of the policy you want to apply"
  type        = string
  default     = ""
}
