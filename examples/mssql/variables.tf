variable "supporting_resources_name" {
  type        = string
  description = "The stack name for supporting resources launched separately"
  default     = "terraform-aws-rds"
}

variable "name" {
  type        = string
  description = "The stack name"
  default     = "exampleinstancemssql"
}

variable "tags" {
  type        = map(string)
  description = "The resource tags to be applied"
  default = {
    Environment        = "example"
    "user::CostCenter" = "terraform-registry"
    Department         = "DevOps"
    Project            = "Examples"
    InstanceScheduler  = true
    Owner              = "hugo.almeida"
    LayerName          = "Example"
    LayerId            = "Example"
  }
}

variable "engine" {
  type        = string
  description = "The database engine to use."
  default     = "sqlserver-ee"
}

variable "instance_class" {
  type        = string
  description = "The instance class for your instance(s)."
  default     = "db.t3.xlarge"
}

variable "port" {
  type        = number
  description = "Port through which db accepts traffic"
  default     = 1433
}

variable "allocated_storage" {
  type        = number
  description = "Enter allocated storage for the db"
  default     = 30
}

variable "max_allocated_storage" {
  type        = number
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance."
  default     = 50
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to enable for exporting to CloudWatch logs."
  default     = ["agent", "error"]
}

variable "create_security_group" {
  type        = bool
  description = "Whether to create a Security Group for RDS cluster."
  default     = true
}

variable "timezone" {
  type        = string
  description = "Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server."
  default     = "UTC"
}

variable "create_monitoring_role" {
  type        = bool
  description = "Create an IAM role for enhanced monitoring"
  default     = true
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance."
  type        = number
  default     = 30
}

variable "create_option_group" {
  type        = bool
  description = "whether to create option_group resource or not"
  default     = true
}

variable "deletion_protection" {
  type        = bool
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  default     = false
}

variable "license_model" {
  type        = string
  description = "License model information for this DB instance."
  default     = "license-included"
}

variable "major_engine_version" {
  type        = string
  description = "Specify the major version of the engine that this option group should be associated with."
  default     = "15.00"
}

variable "engine_version" {
  type        = string
  description = "Specify the version of the engine for this db"
  default     = "15.00.4153.1.v1"
}
