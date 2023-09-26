locals {
  vpc_id               = data.aws_vpc.supporting.id
  vpc_cidr             = data.aws_vpc.supporting.cidr_block
  partition            = data.aws_partition.current.partition
  cidr_block           = "172.16.0.0/16"
  sec_database_subnets = cidrsubnets(local.cidr_block, 8, 8, 8)
  tags                 = merge({ "Name" = var.identifier }, var.tags)
  database_subnets = [
    for s in data.aws_subnet.database : s.id
  ]
  kms_policy = jsonencode({
    Version = "2012-10-17",
    Id      = "key-default",
    Statement = [
      {
        Sid       = "Enable IAM User Permissions",
        Effect    = "Allow",
        Principal = { "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" },
        Action    = "kms:*",
        Resource  = "*"
      },
      {
        Sid       = "Enable IAM User Permissions",
        Effect    = "Allow",
        Principal = { "Service" : "rds.amazonaws.com" },
        Action    = "kms:Encrypt",
        Resource  = "*"
      },
      {
        Sid       = "Allow RDS Replication Role to Decrypt",
        Effect    = "Allow",
        Principal = { "Service" : "rds.amazonaws.com" },
        Action = [
          "kms:Decrypt",
          "kms:DescribeKey"
        ],
        Resource = "*"
      }
    ]
  })
}
