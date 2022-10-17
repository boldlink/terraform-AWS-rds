###
data "aws_partition" "current" {}

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

data "aws_iam_policy_document" "s3_bucket" {
  version = "2012-10-17"
  statement {
    sid     = "AllowAccess"
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.mysql.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.mysql.bucket}/*"
    ]
  }
}

data "aws_vpc" "supporting" {
  filter {
    name   = "tag:Name"
    values = [local.supporting_resources_name]
  }
}

data "aws_subnets" "database" {
  filter {
    name   = "tag:Name"
    values = ["${local.supporting_resources_name}.isolated.*"]
  }
}

data "aws_subnet" "database" {
  for_each = toset(data.aws_subnets.database.ids)
  id       = each.value
}
