#################################
# MySQL Import from S3 example
#################################
resource "random_string" "rds_usr" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

resource "random_password" "rds_pwd" {
  length  = 16
  special = false
  upper   = false
}

module "s3_import" {
  #checkov:skip=CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default"
  #checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  #checkov:skip=CKV2_AWS_6: "Ensure that S3 bucket has a Public Access block"
  #checkov:skip=CKV_AWS_19: "Ensure all data stored in the S3 bucket is securely encrypted at rest"
  #checkov:skip=CKV_AWS_144: "Ensure that S3 bucket has cross-region replication enabled"
  source         = "../../"
  engine         = "mysql"
  engine_version = "8.0.28"
  instance_class = "db.t2.small"
  subnet_ids     = local.database_subnets
  port           = 3306
  name           = local.db_name
  username       = random_string.rds_usr.result
  password       = random_password.rds_pwd.result

  s3_import = {
    source_engine_version = "8.0.28"
    bucket_name           = aws_s3_bucket.mysql.id
    ingestion_role        = aws_iam_role.s3_acces.arn
  }

  kms_key_id                          = data.aws_kms_alias.rds.target_key_arn
  iam_database_authentication_enabled = true
  multi_az                            = true
  enabled_cloudwatch_logs_exports     = ["general", "error", "slowquery"]
  create_security_group               = true
  create_monitoring_role              = true
  monitoring_interval                 = 30
  deletion_protection                 = false
  vpc_id                              = local.vpc_id
  assume_role_policy                  = data.aws_iam_policy_document.monitoring.json
  policy_arn                          = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version                = "8.0"
  tags                                = local.tags
  options = {
    option = {
      option_name = "MARIADB_AUDIT_PLUGIN"
    }
  }

  depends_on = [
    aws_s3_bucket.mysql,
    aws_iam_policy.s3_bucket
  ]
}
