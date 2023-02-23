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
    sid    = "AllowAccess"
    effect = "Allow"
    actions = [
      "s3:PutObject*",
      "s3:ListBucket",
      "s3:GetObject*",
      "s3:DeleteObject*",
      "s3:GetBucketLocation"
    ]
    resources = [
      "arn:${local.partition}:s3:::${local.name}",
      "arn:${local.partition}:s3:::${local.name}/*"
    ]
  }
}

data "aws_iam_policy_document" "assume_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }
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
