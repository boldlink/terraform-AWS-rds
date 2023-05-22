module "s3_bucket_for_mysql_import" {
  source                 = "boldlink/s3/aws"
  version                = "2.2.0"
  bucket                 = var.name
  sse_sse_algorithm      = var.sse_sse_algorithm
  sse_bucket_key_enabled = var.sse_bucket_key_enabled
  force_destroy          = var.force_destroy
  tags                   = local.tags
}

resource "aws_iam_role" "s3_acces" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
}

resource "aws_iam_policy" "s3_bucket" {
  name   = var.name
  policy = data.aws_iam_policy_document.s3_bucket.json

  provisioner "local-exec" {
    command = "unzip sample_backup.zip && aws s3 sync ${path.module}/sample_backup s3://${module.s3_bucket_for_mysql_import.id}"
  }
}

resource "aws_iam_policy_attachment" "s3_acces" {
  name = var.name
  roles = [
    aws_iam_role.s3_acces.name,
  ]
  policy_arn = aws_iam_policy.s3_bucket.arn
}
