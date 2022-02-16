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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage in gigabytes | `number` | `"5"` | no |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | `bool` | `false` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | `true` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Only set if multi\_az is in the default setting (false) for multi\_az = true leave this blank | `string` | `null` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for | `number` | `"7"` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance\_window | `string` | `"22:00-23:00"` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | On delete, copy all Instance tags to the final snapshot (if final\_snapshot\_identifier is specified) | `bool` | `false` | no |
| <a name="input_create_db_subnet_group"></a> [create\_db\_subnet\_group](#input\_create\_db\_subnet\_group) | (Optional) by default we want to create the subnet group, in the odd case you want to use a external (to the module) subnet group set it to false - see example | `bool` | `true` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | (Optional) The subnet group name to attach the instance (if specified you must also provide the var.subnet\_ids value), if no value is specified the module will create a group for you, | `string` | `null` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). | `list(string)` | `[]` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine to use | `string` | `"MYSQL"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use | `string` | `"8.0.13"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment which the dbInstance is being deployed | `string` | `null` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled | `bool` | `false` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance class for your instance(s), by default we are using db.t2.small because we want to enable encryption, if you disable encryption you can choose  db.t2.micro | `string` | `"db.t2.small"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage\_encrypted is set to true and kms\_key\_id is not specified the default KMS key created in your account will be used | `string` | `null` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | `string` | `"Sun:00:00-Sun:04:00"` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `"0"` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring\_interval is non-zero. | `string` | `null` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Boolean if specified leave availability\_zone empty, default = false | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The DB name to create. If omitted, no database is created initially | `string` | n/a | yes |
| <a name="input_option_group_name"></a> [option\_group\_name](#input\_option\_group\_name) | Name of the option group | `string` | `null` | no |
| <a name="input_other_tags"></a> [other\_tags](#input\_other\_tags) | Other tags for the dbInstance | `map(string)` | `{}` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the DB parameter group to associate or create | `string` | `null` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `string` | `3306` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Boolean to control if instance is publicly accessible | `bool` | `false` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final\_snapshot\_identifier | `bool` | `true` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB instance is encrypted | `bool` | `true` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. | `string` | `"gp2"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Optional) the subnet IDs which the subnet group is going to be attach, only required if you don't specify a value for var.db\_subnet\_group | `list(string)` | `[]` | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the master DB user | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of VPC security groups to associate | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | The hostname of the RDS instance. See also endpoint and port |
| <a name="output_allocated_storage"></a> [allocated\_storage](#output\_allocated\_storage) | The amount of allocated storage. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the RDS instance. |
| <a name="output_availability_zone"></a> [availability\_zone](#output\_availability\_zone) | The availability zone of the instance. |
| <a name="output_backup_retention_period"></a> [backup\_retention\_period](#output\_backup\_retention\_period) | The backup retention period. |
| <a name="output_backup_window"></a> [backup\_window](#output\_backup\_window) | The backup window. |
| <a name="output_ca_cert_identifier"></a> [ca\_cert\_identifier](#output\_ca\_cert\_identifier) | Specifies the identifier of the CA certificate for the DB instance. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The connection endpoint in address:port format. |
| <a name="output_engine"></a> [engine](#output\_engine) | The database engine. |
| <a name="output_engine_version_actual"></a> [engine\_version\_actual](#output\_engine\_version\_actual) | The running version of the database. |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record). |
| <a name="output_id"></a> [id](#output\_id) | The RDS instance ID. |
| <a name="output_instance_class"></a> [instance\_class](#output\_instance\_class) | The RDS instance class. |
| <a name="output_maintenance_window"></a> [maintenance\_window](#output\_maintenance\_window) | The instance maintenance window. |
| <a name="output_multi_az"></a> [multi\_az](#output\_multi\_az) | If the RDS instance is multi AZ enabled. |
| <a name="output_name"></a> [name](#output\_name) | The database name. |
| <a name="output_port"></a> [port](#output\_port) | The database port. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The RDS Resource ID of this instance. |
| <a name="output_status"></a> [status](#output\_status) | The RDS instance status. |
| <a name="output_storage_encrypted"></a> [storage\_encrypted](#output\_storage\_encrypted) | Specifies whether the DB instance is encrypted. |
| <a name="output_username"></a> [username](#output\_username) | The master username for the database. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
