variable "supporting_resources_name" {
  type        = string
  description = "The stack name for supporting resources launched separately"
  default     = "terraform-aws-rds"
}

variable "name" {
  type        = string
  description = "The stack name"
  default     = "exampleinstanceoracle"
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
  default     = "oracle-ee"
}

variable "instance_class" {
  type        = string
  description = "The instance class for your instance(s)."
  default     = "db.m5.xlarge"
}

variable "port" {
  type        = number
  description = "Port through which db accepts traffic"
  default     = 1521
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

variable "multi_az" {
  type        = bool
  description = "Boolean if specified leave availability_zone empty, default = false"
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to enable for exporting to CloudWatch logs."
  default     = ["alert", "audit", "listener", "trace"]
}

variable "create_security_group" {
  type        = bool
  description = "Whether to create a Security Group for RDS cluster."
  default     = true
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

variable "major_engine_version" {
  type        = string
  description = "Specify the major version of the engine that this option group should be associated with."
  default     = "19"
}

variable "engine_version" {
  type        = string
  description = "Specify the version of the engine for this db"
  default     = "19.0.0.0.ru-2022-01.rur-2022-01.r1"
}
