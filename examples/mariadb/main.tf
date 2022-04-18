# #######################
#  MariaDB Engine example
# #######################

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

# We are using the default RDS kms key for encryption in this example.
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

module "rds_instance_mariadb" {
  source                          = "../../"
  engine                          = "mariadb"
  engine_version                  = "10.6.7"
  instance_class                  = "db.m5.xlarge"
  allocated_storage               = 30
  subnet_ids                      = data.aws_subnets.rds.ids
  name                            = "randominstancemariadb"
  username                        = random_string.rds_usr.result
  password                        = random_password.rds_pwd.result
  kms_key_id                      = data.aws_kms_alias.rds.target_key_arn
  environment                     = "beta"
  port                            = 3306
  multi_az                        = true
  enabled_cloudwatch_logs_exports = ["error", "audit", "general", "slowquery"]
  create_security_group           = true
  create_monitoring_role          = true
  monitoring_interval             = 30
  deletion_protection             = false
  create_option_group             = true
  assume_role_policy              = data.aws_iam_policy_document.monitoring.json
  policy_arn                      = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version            = "10.6"
  other_tags = {
    "cost_center" = "random"
  }
}

# Example of outputs
output "address" {
  value = [
    module.rds_instance_mariadb,
  ]
}
