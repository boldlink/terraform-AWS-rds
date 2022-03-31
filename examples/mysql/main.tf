provider "aws" {
  region = "eu-west-1"
}

# Grab the subnets ids to be used, we are using the default VPC for the example.
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

resource "random_string" "rds_usr" {
  length  = 5
  special = false
  upper   = false
  number  = false
}
resource "random_password" "rds_pwd" {
  length  = 16
  special = false
  upper   = false
}

# Default minimal setup
module "rds_instance_mysql" {
  source                          = "../../"
  subnet_ids                      = data.aws_subnets.rds.ids
  name                            = "randominstancemysql"
  username                        = random_string.rds_usr.result
  password                        = random_password.rds_pwd.result
  kms_key_id                      = data.aws_kms_alias.rds.target_key_arn
  environment                     = "beta"
  port                            = 3306
  multi_az                        = true
  enabled_cloudwatch_logs_exports = ["general", "error", "slowquery"]
  create_security_group           = true
  other_tags = {
    "cost_center" = "random"
  }
}

# Example of oututs
output "address" {
  description = "Example of outputs"
  value = [
    module.rds_instance_mysql,

  ]
}
