module "replication_role" {
  source                = "boldlink/iam-role/aws"
  version               = "1.1.0"
  name                  = "${var.name}-replication-role"
  description           = "S3 replication role"
  assume_role_policy    = local.assume_role_policy
  force_detach_policies = true
  policies = {
    "${var.name}-replication-policy" = {
      policy = local.role_policy
    }
  }
}

module "replication_bucket" {
  source                 = "boldlink/s3/aws"
  version                = "2.2.0"
  sse_bucket_key_enabled = false
  bucket                 = local.replication_bucket
  sse_sse_algorithm      = "AES256"
  force_destroy          = true
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )

  providers = {
    aws = aws.dest
  }
}

module "s3_logging" {
  source        = "boldlink/s3/aws"
  version       = "2.2.0"
  bucket        = "${var.name}-logging-bucket"
  force_destroy = true
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )
}

module "mysql" {
  source                 = "boldlink/s3/aws"
  version                = "2.2.0"
  bucket                 = var.name
  sse_sse_algorithm      = "AES256"
  sse_bucket_key_enabled = false
  force_destroy          = true
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )

  s3_logging = {
    target_bucket = module.s3_logging.bucket
    target_prefix = "/logs"
  }

  replication_configuration = {
    role = module.replication_role.arn
    rules = [
      {
        id     = "everything"
        status = "Enabled"

        delete_marker_replication = {
          status = "Enabled"
        }

        destination = {
          bucket        = module.replication_bucket.arn
          storage_class = "STANDARD"
        }

        source_selection_criteria = {
          replica_modifications = {
            status = "Enabled"
          }
        }
      }
    ]
  }

  depends_on = [module.s3_logging]
}

module "s3_acces_role" {
  source                = "boldlink/iam-role/aws"
  version               = "1.1.0"
  name                  = var.name
  assume_role_policy    = data.aws_iam_policy_document.assume_policy.json
  description           = "Role for mysql instance to access artifacts from s3"
  force_detach_policies = true
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )

  policies = {
    "${var.name}-policy" = {
      policy = data.aws_iam_policy_document.s3_bucket.json
      tags = merge(
        {
          "Name" = var.name
        },
        var.tags,
      )
    }
  }
}

resource "null_resource" "s3_sync" {
  provisioner "local-exec" {
    command = "unzip sample_backup.zip && aws s3 sync ${path.module}/sample_backup s3://${module.mysql.id}"
  }

  depends_on = [
    module.mysql,
    module.s3_acces_role
  ]
}
