variable "supporting_resources_name" {
  type        = string
  description = "The stack name for supporting resources launched separately"
  default     = "terraform-aws-rds"
}

variable "db_name" {
  type        = string
  description = "The database name to create"
  default     = "exampleminimuminstance"
}

variable "tags" {
  type        = map(string)
  description = "The resource tags to be applied"
  default = {
    Environment        = "example"
    "user::CostCenter" = "terraform-registry"
    Department         = "DevOps"
    Project            = "Examples"
    Owner              = "hugo.almeida"
    InstanceScheduler  = true
    LayerName          = "Example"
    LayerId            = "Example"
  }
}

variable "instance_class" {
  type        = string
  description = "The instance class for your instance(s)."
  default     = "db.t2.small"
}

variable "deletion_protection" {
  type        = bool
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  default     = false
}
