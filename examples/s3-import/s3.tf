resource "aws_s3_bucket" "mysql" {
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
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
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

resource "aws_iam_policy_attachment" "s3_acces" {
  name = "s3-import"
  roles = [
    "${aws_iam_role.s3_acces.name}"
  ]
  policy_arn = aws_iam_policy.s3_bucket.arn
}
