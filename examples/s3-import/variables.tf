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
