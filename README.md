Terraform module for creating a MySQL RDS instance.

## Description

This template creates a database instance running on mysql version 8.0.13, port 3306 and a database subnet group.

Example available [here](./example/main.tf)

# Security Check

[Note:] The warning:

`CKV_AWS_129`: Ensure that respective logs of Amazon Relational Database Service (Amazon RDS) triggers a bug in checkov scan and we have added this code to `.checkov.yml` configuration of the example. We have reported the issue [here](https://github.com/bridgecrewio/checkov/issues/1943).

See [CHECKOV.md](https://github.com/boldlink/terraform-labs-modules/blob/develop/CHECKOV.md) for more information on usage options and configuration used.

## Documentation

[AWS DB Instance documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.DBInstance.html)
[Terraform AWS DB Instance documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance)

[AWS Subnet Group documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Subnets)
[Terraform AWS Subnet Group documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group)

## Resources

This stack will deploy the following resources:

| Resource | Required |
|----------|:--------:|
| aws_rds_instance.main | Yes |
| aws_db_subnet_group.main | No      |

## Terraform version

0.13+

## Providers

Minimum version of providers necessary for the deployment of this stack

| Name | Version | Observations |
|------|---------|--------------|
| aws  | 3.63+    | AWS Provider version used on tests, possible it works with other versions, but untested |



## Inputs

The list below breaksdown the variables required or available.

| Name                    | Type     | Required | Description | 
|------------------------ |--------- |----------|-------------|
| instance_class         | `String` | Yes | The instance type of the RDS instance|
| storage_type            | `String` | No | One of "standard" (magnetic), "gp2" (general purpose SSD), or "io1" (provisioned IOPS SSD). The default is "io1" if iops is specified, "gp2" if not|
| allocated_storage       | `number` | Yes | The allocated storage in gigabytes| 
| allow_major_version_upgrade | `bool` | No | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | 
| auto_minor_version_upgrade | `bool` | No | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true.| 
| backup_retention_period | `String` | No | The days to retain backups for. Must be between 0 and 35 |
| backup_window           | `String`   | No | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: "09:46-10:16". Must not overlap with maintenance_window |
| enabled_cloudwatch_logs_exports  | `String`   | No| Set of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported |
| iam_database_authentication_enabled | `bool`   | No | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled |
| instance_class          | `String`   | Yes | The instance type of the RDS instance |
| maintenance_window      | `String`   | No | The window to perform maintenance in. Syntax: "ddd:hh24:mi-ddd:hh24:mi". Eg: "Mon:00:00-Mon:03:00" |
| availability_zone       | `String`   | No | The AZ for the RDS instance |
| multi_az                | `String`   | No | Specifies if the RDS instance is multi-AZ |
| option_group_name       | `String`   | No | Name of the DB option group to associate |
| parameter_group_name    | `String`   | No | Name of the DB parameter group to associate.|
| username                | `String`   | yes | Username for the master DB user. (Required unless a snapshot_identifier or replicate_source_db is provided)  |
| password                | `String`   | yes | Password for the master DB user.(Required unless a snapshot_identifier or replicate_source_db is provided)  |
| port                    | `number`   | No | The port on which the DB accepts connections.|
| vpc_security_group_ids  | `String`   | No | List of VPC security groups to associate|
| parameter_group_name    | `String`   | No | Name of the DB parameter group to associate. |
| skip_final_snapshot     | `bool`     | No | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier. Default is false|
| storage_encrypted       | `bool`     | No | Specifies whether the DB instance is encrypted. Note that if you are creating a cross-region read replica this field is ignored and you should instead declare kms_key_id with a valid ARN. The default is false if not specified. |
| engine                  | `String`   | Yes | | The database engine to use |
| engine_version          | `number`   | No | The engine version to use |
| name                    | `String`   | Yes | The DB name to create. If omitted, no database is created initially|
| PasswordLength          | `number`   | Yes | The length of the string desired. |
| copy_tags_to_snapshot   | `String`   | No | On delete, copy all Instance tags to the final snapshot|
| publicly_accessible     | `String`   | No | Bool to control if instance is publicly accessible. Default is false.|
| DeletionProtection      | `String`   | No | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false|
| Subnet_ids         |  `List`    | Yes | A list of VPC subnet IDs |
| name            | `String`   | No | a name tag to associate the database with|
| environment        | `String`   | yes | Tag to associate the database with an environment |



## Outputs

| Name                 | Description |
|----------------------|-------------|
| address              |  The hostname of the RDS instance |
| arn                  | The ARN of the RDS instance.   |
| allocated_storage    | The amount of allocated storage. |
| availability_zone    | The availability zone of the instance. |
| backup_retention_period | The backup retention period|
| backup_window        | The backup window. |
| ca_cert_identifier   | Specifies the identifier of the CA certificate for the DB instance. |
| endpoint             | The connection endpoint in address:port format |
| engine               | the engine of the database instance |
| engine_version_actual  | The running version of the database|
| hosted_zone_id       | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record). |
| id                   |  The RDS instance ID |
| maintenance_window   | the maintence window of db instance |
| multi_az             | is the db instance running on multi az |
| name                 | Name of the db instance |
| port                 | Port of the db instance |
| resource_id          | the resource id of the db instance |
| status               |the status of the db instance |
| storage_encrypted    | db instance storage encrytion |
| username             | username used in the db instance |



