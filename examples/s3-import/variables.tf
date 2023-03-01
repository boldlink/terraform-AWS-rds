#(empty)
variable "supporting_resources_name" {
  type        = string
  description = "The stack name for supporting resources launched separately"
  default     = "terraform-aws-rds"
}

variable "region_1" {
  type        = string
  description = "The default region where all other resources are deployed"
  default     = "eu-west-1"
}

variable "region_2" {
  type        = string
  description = "The second region to deploy replication bucket"
  default     = "eu-west-2"
}

variable "name" {
  type        = string
  description = "Name of the stack"
  default     = "mysql-s3-import-example"
}

variable "db_name" {
  type        = string
  description = "Name of the database"
  default     = "examples3db"
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
    Owner              = "Boldlink"
    LayerName          = "Example"
    LayerId            = "Example"
  }
}
