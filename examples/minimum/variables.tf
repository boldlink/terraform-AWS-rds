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
    Owner              = "Boldlink"
    InstanceScheduler  = true
    LayerName          = "Example"
    LayerId            = "Example"
  }
}
