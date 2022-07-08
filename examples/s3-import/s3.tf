resource "aws_s3_bucket" "mysql" {
  #checkov:skip=CKV2_AWS_6: Ensure that S3 bucket has a Public Access block
  #checkov:skip=CKV_AWS_19: Ensure all data stored in the S3 bucket is securely encrypted at rest
  #checkov:skip=CKV_AWS_144: Ensure that S3 bucket has cross-region replication enabled
  #checkov:skip=CKV_AWS_18: Ensure the S3 bucket has access logging enabled
  bucket        = "mysql-import-bucket"
  force_destroy = true

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

resource "aws_iam_role" "s3_acces" {
  name               = "rds_s3_import"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
}

resource "aws_iam_policy" "s3_bucket" {
  name   = "s3-import"
  policy = <<POLICY
{
    "Version": 2012-10-17",
    "Statement": [
        {
            "Effect": Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "${aws_s3_bucket.mysql.arn}",
                "${aws_s3_bucket.mysql.arn}/*"
            ]
        }
    ]
}
POLICY
  provisioner "local-exec" {
    command = "unzip sample_backup.zip && aws s3 sync ${path.module}/sample_backup s3://${aws_s3_bucket.mysql.id}"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.mysql.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.mysql.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_policy_attachment" "s3_acces" {
  name = "s3-import"
  roles = [
    aws_iam_role.s3_acces.name,
  ]
  policy_arn = aws_iam_policy.s3_bucket.arn
}
