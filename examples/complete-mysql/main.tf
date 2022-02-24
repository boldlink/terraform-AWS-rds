provider "aws" {
  region = "eu-west-1"
}

# Grab the subnets ids to be used, we are using the default VPC for the example.
# In a real deployment you wouldn't use these subnets, not even on a Dev environment.
data "aws_vpc" "rds" {
  filter {

    name   = "tag:Name"
    values = ["default"]

  }
}

data "aws_subnets" "rds" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.rds.id]
  }
}

# We are using the default RDS kms key for encryption.
# Make sure you use the kms key arn
data "aws_kms_alias" "rds" {
  name = "alias/aws/rds"
}

# Used for demostration only, not the recommended setup for user/passwords
resource "random_string" "rds_usr" {
  length  = 5
  special = false
  upper   = false
}
resource "random_string" "rds_pwd" {
  length  = 16
  special = false
  upper   = false
}

resource "random_string" "rds_usr2" {
  length  = 5
  special = false
  upper   = false
}
resource "random_string" "rds_pwd2" {
  length  = 16
  special = false
  upper   = false
}

# Default minimal setup
module "rds_instance_complete" {
  source                          = "boldlink/rds/aws"
  version                         = "1.0.2"
  subnet_ids                      = data.aws_subnets.rds.ids
  name                            = "randominstancecomplete"
  username                        = random_string.rds_usr.result
  password                        = random_string.rds_pwd.result
  kms_key_id                      = data.aws_kms_alias.rds.target_key_arn
  environment                     = "beta"
  monitoring_interval             = "0"
  multi_az                        = "true"
  enabled_cloudwatch_logs_exports = ["general", "error", "slowquery"]
  other_tags = {
    "cost_center" = "random2"
  }
}

# Using an external RDS Subnet Group
module "rds_subnet_group" {
  source      = "boldlink/db-subnet-group/aws"
  version     = "1.0.0"
  name        = "random_rds_subnet"
  subnet_ids  = data.aws_subnets.rds.ids
  environment = "beta"
  other_tags = {
    "cost_center" = "random1"
  }
}

module "rds_instance_external" {

  source                          = "boldlink/rds/aws"
  version                         = "1.0.2"
  create_db_subnet_group          = false # When using a subnet group external to the module
  db_subnet_group_name            = module.rds_subnet_group.id
  name                            = "randominstance1"
  username                        = random_string.rds_usr2.result
  password                        = random_string.rds_pwd2.result
  kms_key_id                      = data.aws_kms_alias.rds.target_key_arn
  environment                     = "beta"
  monitoring_interval             = "0"
  multi_az                        = "true"
  enabled_cloudwatch_logs_exports = ["general", "error", "slowquery"]
  other_tags = {
    "cost_center" = "random1"
  }
}

# Example of oututs
output "address" {
  description = "Example of outputs"
  value = [
    module.rds_instance_external.address,
    module.rds_instance_complete.address
  ]
}
