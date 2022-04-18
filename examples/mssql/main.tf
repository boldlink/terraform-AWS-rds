# ######################
#  MsSQL Engine example
# ######################

provider "aws" {
  region = "eu-west-1"
}

data "aws_partition" "current" {}

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

data "aws_iam_policy_document" "monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
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

module "rds_instance_mssql" {
  source                          = "../../"
  engine                          = "sqlserver-ee"
  allocated_storage               = 30
  engine_version                  = "15.00.4153.1.v1"
  instance_class                  = "db.t3.xlarge"
  subnet_ids                      = data.aws_subnets.rds.ids
  name                            = "randominstancemssql"
  username                        = random_string.rds_usr.result
  password                        = random_password.rds_pwd.result
  environment                     = "beta"
  port                            = 1433
  enabled_cloudwatch_logs_exports = ["agent", "error"]
  create_security_group           = true
  create_monitoring_role          = true
  monitoring_interval             = 30
  create_option_group             = true
  deletion_protection             = false
  assume_role_policy              = data.aws_iam_policy_document.monitoring.json
  policy_arn                      = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version            = "15.00"
  timezone                        = "UTC"
  license_model                   = "license-included"
  storage_encrypted               = false
  other_tags = {
    "cost_center" = "random"
  }
}

# Example of outputs
output "address" {
  value = [
    module.rds_instance_mssql,
  ]
}
