Terraform module for creating an RDS instance resource.

## Description

This template creates a database instance running on mysql version 8.0.13, port 3306 and a database subnet group.

Example available [here](https://github.com/boldlink/terraform-aws-rds/tree/main/examples/complete-mysql)

# Security Check

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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_option_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_option_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | (Required unless a snapshot\_identifier or replicate\_source\_db is provided) The allocated storage in gibibytes. If max\_allocated\_storage is configured, this argument represents the initial storage allocation and differences from the configuration will be ignored automatically when Storage Autoscaling occurs. If replicate\_source\_db is set, the value is ignored during the creation of the instance. | `number` | `"5"` | no |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | `bool` | `false` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | (Required) Policy that grants an entity permission to assume the role. | `string` | `""` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | `true` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Only set if multi\_az is in the default setting (false) for multi\_az = true leave this blank | `string` | `null` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for | `number` | `7` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance\_window | `string` | `"03:00-04:00"` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | The identifier of the CA certificate for the DB instance. | `string` | `null` | no |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | List of CIDR blocks | `string` | `"0.0.0.0/0"` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | On delete, copy all Instance tags to the final snapshot (if final\_snapshot\_identifier is specified) | `bool` | `false` | no |
| <a name="input_create_db_subnet_group"></a> [create\_db\_subnet\_group](#input\_create\_db\_subnet\_group) | (Optional) by default we want to create the subnet group, in the odd case you want to use a external (to the module) subnet group set it to false - see example | `bool` | `true` | no |
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | Create an IAM role for enhanced monitoring | `bool` | `false` | no |
| <a name="input_create_option_group"></a> [create\_option\_group](#input\_create\_option\_group) | whether to create option\_group resource or not | `bool` | `false` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create a Security Group for RDS cluster. | `bool` | `false` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | (Optional) The subnet group name to attach the instance (if specified you must also provide the var.subnet\_ids value), if no value is specified the module will create a group for you, | `string` | `null` | no |
| <a name="input_delete_automated_backups"></a> [delete\_automated\_backups](#input\_delete\_automated\_backups) | Specifies whether to remove automated backups immediately after the DB instance is deleted. Default is true. | `bool` | `true` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false. | `bool` | `false` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The ID of the Directory Service Active Directory domain to create the instance in. | `string` | `null` | no |
| <a name="input_domain_iam_role_name"></a> [domain\_iam\_role\_name](#input\_domain\_iam\_role\_name) | The name of the IAM role to be used when making API calls to the Directory Service. | `string` | `null` | no |
| <a name="input_egress_protocol"></a> [egress\_protocol](#input\_egress\_protocol) | (Required) Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"-1"` | no |
| <a name="input_egress_type"></a> [egress\_type](#input\_egress\_type) | (Required) Type of rule being created. Valid options are ingress (inbound) or egress (outbound) | `string` | `"egress"` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). | `list(string)` | `[]` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | (Required unless a snapshot\_identifier or replicate\_source\_db is provided) The database engine to use. | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment which the dbInstance is being deployed | `string` | `null` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | The name of your final DB snapshot when this DB instance is deleted. Must be provided if skip\_final\_snapshot is set to false. The value must begin with a letter, only contain alphanumeric characters and hyphens, and not end with a hyphen or contain two consecutive hyphens. Must not be provided when deleting a read replica. | `string` | `null` | no |
| <a name="input_from_port"></a> [from\_port](#input\_from\_port) | (Required) Start port (or ICMP type number if protocol is 'icmp' or 'icmpv6') | `number` | `0` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled | `bool` | `false` | no |
| <a name="input_identifier_prefix"></a> [identifier\_prefix](#input\_identifier\_prefix) | Creates a unique identifier beginning with the specified prefix. Conflicts with identifier. | `string` | `null` | no |
| <a name="input_ingress_protocol"></a> [ingress\_protocol](#input\_ingress\_protocol) | (Required) Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"tcp"` | no |
| <a name="input_ingress_type"></a> [ingress\_type](#input\_ingress\_type) | (Required) Type of rule being created. Valid options are ingress (inbound) or egress (outbound) | `string` | `"ingress"` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance class for your instance(s), by default we are using db.t2.small because we want to enable encryption, if you disable encryption you can choose  db.t2.micro | `string` | `"db.t2.small"` | no |
| <a name="input_instance_timeouts"></a> [instance\_timeouts](#input\_instance\_timeouts) | aws\_rds\_instance provides the following Timeouts configuration options: create, update, delete | <pre>list(object({<br>    create = string<br>    update = string<br>    delete = string<br>  }))</pre> | `[]` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage\_encrypted is set to true and kms\_key\_id is not specified the default KMS key created in your account will be used | `string` | `null` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | `string` | `"Sun:00:00-Sun:02:00"` | no |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | (Required) Specifies the major version of the engine that this option group should be associated with. | `string` | `""` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring\_interval is non-zero. | `string` | `null` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Boolean if specified leave availability\_zone empty, default = false | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The DB name to create. If omitted, no database is created initially | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name. Must be lowercase, to match as it is stored in AWS. | `string` | `null` | no |
| <a name="input_option_group_name"></a> [option\_group\_name](#input\_option\_group\_name) | (Optional) Name of the DB option group to associate. | `string` | `""` | no |
| <a name="input_options"></a> [options](#input\_options) | (Optional) A list of Options to apply. | `any` | `[]` | no |
| <a name="input_other_tags"></a> [other\_tags](#input\_other\_tags) | Other tags for the dbInstance | `map(string)` | `{}` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the DB parameter group to associate or create | `string` | `null` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string` | n/a | yes |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Specifies whether Performance Insights are enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | The ARN for the KMS key to encrypt Performance Insights data. When specifying performance\_insights\_kms\_key\_id, performance\_insights\_enabled needs to be set to true. Once KMS key is set, it can never be changed. | `string` | `null` | no |
| <a name="input_performance_insights_retention_period"></a> [performance\_insights\_retention\_period](#input\_performance\_insights\_retention\_period) | The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years). When specifying performance\_insights\_retention\_period, performance\_insights\_enabled needs to be set to true. Defaults to '7'. | `number` | `0` | no |
| <a name="input_policy_arn"></a> [policy\_arn](#input\_policy\_arn) | (Required) - The ARN of the policy you want to apply | `string` | `""` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `string` | n/a | yes |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Boolean to control if instance is publicly accessible | `bool` | `false` | no |
| <a name="input_replicate_source_db"></a> [replicate\_source\_db](#input\_replicate\_source\_db) | Specifies that this resource is a Replicate database, and to use this value as the source database. | `string` | `null` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final\_snapshot\_identifier | `bool` | `true` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05. | `string` | `null` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB instance is encrypted | `bool` | `true` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. | `string` | `"gp2"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Required) A list of VPC subnet IDs. | `list(string)` | `[]` | no |
| <a name="input_to_port"></a> [to\_port](#input\_to\_port) | (Required) End port (or ICMP code if protocol is 'icmp') | `number` | `0` | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the master DB user | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional, Forces new resource) VPC ID | `string` | `null` | no |
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
| <a name="output_character_set_name"></a> [character\_set\_name](#output\_character\_set\_name) | The character set (collation) used on Oracle and Microsoft SQL instances. |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | The database name. |
| <a name="output_domain"></a> [domain](#output\_domain) | The ID of the Directory Service Active Directory domain the instance is joined to |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The connection endpoint in address:port format. |
| <a name="output_engine"></a> [engine](#output\_engine) | The database engine. |
| <a name="output_engine_version_actual"></a> [engine\_version\_actual](#output\_engine\_version\_actual) | The running version of the database. |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record). |
| <a name="output_id"></a> [id](#output\_id) | The RDS instance ID. |
| <a name="output_instance_class"></a> [instance\_class](#output\_instance\_class) | The RDS instance class. |
| <a name="output_latest_restorable_time"></a> [latest\_restorable\_time](#output\_latest\_restorable\_time) | The latest time, in UTC RFC3339 format, to which a database can be restored with point-in-time restore. |
| <a name="output_maintenance_window"></a> [maintenance\_window](#output\_maintenance\_window) | The instance maintenance window. |
| <a name="output_multi_az"></a> [multi\_az](#output\_multi\_az) | If the RDS instance is multi AZ enabled. |
| <a name="output_port"></a> [port](#output\_port) | The database port. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The RDS Resource ID of this instance. |
| <a name="output_status"></a> [status](#output\_status) | The RDS instance status. |
| <a name="output_storage_encrypted"></a> [storage\_encrypted](#output\_storage\_encrypted) | Specifies whether the DB instance is encrypted. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags |
| <a name="output_username"></a> [username](#output\_username) | The master username for the database. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
