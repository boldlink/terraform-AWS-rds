[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-rds/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-rds.svg)](https://github.com/boldlink/terraform-aws-rds/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/auto-merge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# AWS RDS Terraform module

## Description

This Terraform module allows you to create a full AWS RDS setup with a single module. It combines all the AWS resources required to properly configure your RDS instance, network, IAM, security and more.

**NOTE!!!** As of version 1.3.0 several braking changes where introduced:
* Database name no longers uses the value from `var.name`, instead it requires `var.db_name` value in this and newer versions of this module.
* `var.create_security_group = true` as been set as default (previously set to `false`) which means a empty SG will be created, you must then add the bellow information (see example for postgres):

```hcl
data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = ["example*.pri.*"]
  }
}

data "aws_subnet" "eks_nodes" {
  for_each = toset(data.aws_subnets.private_subnets.ids)
  id       = each.value
}

module "example" {
  source                = "boldlink/rds/aws"
  version               = "<harcoded_version>"
  engine                = "postgres"
...
  security_group_ingress = [{
      from_port        = 5432
      to_port          = 5432
      protocol         = "tcp"
      cidr_blocks      = [for s in data.aws_subnet.eks_nodes : s.cidr_block]
  }]
...
}
```


### Why choose this module over the standard resources
- Multiple RDS engines: This module supports multiple RDS engines, including MySQL, PostgreSQL, MariaDB, Oracle, and SQL Server.

- Multiple database versions: This module supports multiple database versions, including MySQL 5.6, MySQL 5.7, MySQL 8.0, PostgreSQL 9.6, PostgreSQL 10, PostgreSQL 11, PostgreSQL 12, MariaDB 10.1, MariaDB 10.2, MariaDB 10.3, MariaDB 10.4, Oracle 11.2, Oracle 12.1, Oracle 12.2, SQL Server 2016, and SQL Server 2017.

- Working example to create your RDS instance(s) from a snapshot.

- Development and Production environments: This module supports creating RDS instances for both development and production environments. It also supports creating RDS instances with different configurations for each environment.

- Validated configurations: The default and custom configurations included in this module have been validated by Chekov, which is an open-source tool used for automated cloud security posture management. This ensures that the configurations adhere to best practices and security standards, reducing the risk of misconfiguration and security vulnerabilities.

- Ease of use: This module includes several examples demonstrating different usage scenarios, making it easier for users to understand and use. It also abstracts the complexity of creating and configuring multiple resources required for an RDS instance, making it simpler and quicker to create and manage RDS instances.

- Time-saving: By using this module, most of the resources and features required for creating and managing RDS instances are already included. This saves time for developers and system administrators who would otherwise need to spend time creating and configuring the resources manually.

- Well-configured IAM permissions: The module has well-configured IAM permissions for some of the features, which helps to ensure that users have the appropriate level of access to the resources they need. This reduces the risk of unauthorized access or misconfigured permissions, which can lead to security breaches.

Examples available [here](./examples)

## Usage
**NOTE**: These examples use the latest version of this module

## **Security Notice**
The following checkov checks have been disabled for the minimum example because this intended for development environment. All these should be enabled in a production environment
- CKV_AWS_129: "Ensure that respective logs of Amazon Relational Database Service (Amazon RDS) are enabled"

```hcl
module "minimum" {
  source              = "boldlink/rds/aws"
  engine              = "mysql"
  vpc_id              = local.vpc_id
  subnet_ids          = local.database_subnets
  security_group_ingress = [{
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = [local.cidr_block]
  }]
  name                = var.db_name
  deletion_protection = false
  instance_class      = "db.t2.small"
  username            = random_string.rds_usr.result
  password            = random_password.rds_pwd.result
  tags = merge(
    {
      "Name" = var.db_name
    },
    var.tags,
  )
}
```
## Documentation

[AWS DB Instance documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.DBInstance.html)
[Terraform AWS DB Instance documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance)

[AWS Subnet Group documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Subnets)
[Terraform AWS Subnet Group documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group)

[AWS Parameter Group documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithParamGroups.html)
[Terraform AWS Parameter Group documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.12.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_option_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_option_group) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | (Required unless a snapshot\_identifier or replicate\_source\_db is provided) The allocated storage in gibibytes. If max\_allocated\_storage is configured, this argument represents the initial storage allocation and differences from the configuration will be ignored automatically when Storage Autoscaling occurs. If replicate\_source\_db is set, the value is ignored during the creation of the instance. | `number` | `5` | no |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | `bool` | `false` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | (Required) Policy that grants an entity permission to assume the role. | `string` | `""` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | `true` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Only set if multi\_az is in the default setting (false) for multi\_az = true leave this blank | `string` | `null` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for | `number` | `7` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance\_window | `string` | `"03:00-04:00"` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | The identifier of the CA certificate for the DB instance. | `string` | `null` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | On delete, copy all Instance tags to the final snapshot (if final\_snapshot\_identifier is specified) | `bool` | `true` | no |
| <a name="input_create_db_subnet_group"></a> [create\_db\_subnet\_group](#input\_create\_db\_subnet\_group) | (Optional) by default we want to create the subnet group, in the odd case you want to use a external (to the module) subnet group set it to false - see example | `bool` | `true` | no |
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | Create an IAM role for enhanced monitoring | `bool` | `false` | no |
| <a name="input_create_option_group"></a> [create\_option\_group](#input\_create\_option\_group) | whether to create option\_group resource or not | `bool` | `false` | no |
| <a name="input_create_parameter_group"></a> [create\_parameter\_group](#input\_create\_parameter\_group) | whether to create parameter group resource or not | `bool` | `false` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create a Security Group for RDS cluster. | `bool` | `true` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The default database name (mandatory) | `string` | n/a | yes |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | (Optional) The subnet group name to attach the instance (if specified you must also provide the var.subnet\_ids value), if no value is specified the module will create a group for you, | `string` | `null` | no |
| <a name="input_delete_automated_backups"></a> [delete\_automated\_backups](#input\_delete\_automated\_backups) | Specifies whether to remove automated backups immediately after the DB instance is deleted. Default is true. | `bool` | `true` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false. | `bool` | `true` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The ID of the Directory Service Active Directory domain to create the instance in. | `string` | `null` | no |
| <a name="input_domain_iam_role_name"></a> [domain\_iam\_role\_name](#input\_domain\_iam\_role\_name) | The name of the IAM role to be used when making API calls to the Directory Service. | `string` | `null` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). | `list(string)` | `[]` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | (Required unless a snapshot\_identifier or replicate\_source\_db is provided) The database engine to use. | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use | `string` | `null` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | The name of your final DB snapshot when this DB instance is deleted. Must be provided if skip\_final\_snapshot is set to false. The value must begin with a letter, only contain alphanumeric characters and hyphens, and not end with a hyphen or contain two consecutive hyphens. Must not be provided when deleting a read replica. | `string` | `null` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled | `bool` | `false` | no |
| <a name="input_identifier_prefix"></a> [identifier\_prefix](#input\_identifier\_prefix) | Creates a unique identifier beginning with the specified prefix. Conflicts with identifier. | `string` | `null` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance class for your instance(s). | `string` | `null` | no |
| <a name="input_instance_timeouts"></a> [instance\_timeouts](#input\_instance\_timeouts) | aws\_rds\_instance provides the following Timeouts configuration options: create, update, delete | <pre>list(object({<br>    create = string<br>    update = string<br>    delete = string<br>  }))</pre> | `[]` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage\_encrypted is set to true and kms\_key\_id is not specified the default KMS key created in your account will be used | `string` | `null` | no |
| <a name="input_license_model"></a> [license\_model](#input\_license\_model) | (Optional, but required for some DB engines, i.e., Oracle SE1) License model information for this DB instance. | `string` | `null` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | `string` | `"Sun:00:00-Sun:02:00"` | no |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | (Required) Specifies the major version of the engine that this option group should be associated with. | `string` | `""` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | (Optional) When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to allocated\_storage. Must be greater than or equal to allocated\_storage or 0 to disable Storage Autoscaling. | `number` | `0` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring\_interval is non-zero. | `string` | `null` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Boolean if specified leave availability\_zone empty, default = false | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The DB name to create. If omitted, no database is created initially | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name. Must be lowercase, to match as it is stored in AWS. | `string` | `null` | no |
| <a name="input_nchar_character_set_name"></a> [nchar\_character\_set\_name](#input\_nchar\_character\_set\_name) | (Optional, Forces new resource) The national character set is used in the NCHAR, NVARCHAR2, and NCLOB data types for Oracle instances. This can't be changed. | `string` | `null` | no |
| <a name="input_option_group_name"></a> [option\_group\_name](#input\_option\_group\_name) | (Optional) Name of the DB option group to associate. | `string` | `null` | no |
| <a name="input_options"></a> [options](#input\_options) | (Optional) A list of Options to apply. | `any` | `[]` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | The family of the DB parameter group. | `string` | `null` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the DB parameter group to associate or create | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A list of DB parameters to apply. Note that parameters may differ from a family to an other. | `any` | `[]` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string` | n/a | yes |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Specifies whether Performance Insights are enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | The ARN for the KMS key to encrypt Performance Insights data. When specifying performance\_insights\_kms\_key\_id, performance\_insights\_enabled needs to be set to true. Once KMS key is set, it can never be changed. | `string` | `null` | no |
| <a name="input_performance_insights_retention_period"></a> [performance\_insights\_retention\_period](#input\_performance\_insights\_retention\_period) | The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years). When specifying performance\_insights\_retention\_period, performance\_insights\_enabled needs to be set to true. Defaults to '7'. | `number` | `0` | no |
| <a name="input_policy_arn"></a> [policy\_arn](#input\_policy\_arn) | (Required) - The ARN of the policy you want to apply | `string` | `""` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `number` | `3306` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Boolean to control if instance is publicly accessible | `bool` | `false` | no |
| <a name="input_replica_mode"></a> [replica\_mode](#input\_replica\_mode) | (Optional) Specifies whether the replica is in either mounted or open-read-only mode. This attribute is only supported by Oracle instances. Oracle replicas operate in open-read-only mode unless otherwise specified. | `string` | `null` | no |
| <a name="input_replicate_source_db"></a> [replicate\_source\_db](#input\_replicate\_source\_db) | Specifies that this resource is a Replicate database, and to use this value as the source database. | `string` | `null` | no |
| <a name="input_restore_to_point_in_time"></a> [restore\_to\_point\_in\_time](#input\_restore\_to\_point\_in\_time) | (Optional, Forces new resource) A configuration block for restoring a DB instance to an arbitrary point in time. Requires the identifier argument to be set with the name of the new DB instance to be created. | <pre>list(object({<br>    restore_time                             = string<br>    source_db_instance_identifier            = string<br>    source_db_instance_automated_backups_arn = string<br>    source_dbi_resource_id                   = string<br>    use_latest_restorable_time               = bool<br>  }))</pre> | `[]` | no |
| <a name="input_s3_import"></a> [s3\_import](#input\_s3\_import) | (Optional) Restore from a Percona Xtrabackup in S3.(Only MySQL is supported). | `map(string)` | `null` | no |
| <a name="input_security_group_egress"></a> [security\_group\_egress](#input\_security\_group\_egress) | The rules block for defining additional egress rules | `any` | `[]` | no |
| <a name="input_security_group_ingress"></a> [security\_group\_ingress](#input\_security\_group\_ingress) | The rules block for defining additional ingress rules | `any` | `[]` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final\_snapshot\_identifier | `bool` | `true` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05. | `string` | `null` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB instance is encrypted | `bool` | `true` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Required) A list of VPC subnet IDs. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | (Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. | `string` | `null` | no |
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
| <a name="output_sg_arn"></a> [sg\_arn](#output\_sg\_arn) | ARN of the security group. |
| <a name="output_sg_id"></a> [sg\_id](#output\_sg\_id) | ID of the security group.. |
| <a name="output_status"></a> [status](#output\_status) | The RDS instance status. |
| <a name="output_storage_encrypted"></a> [storage\_encrypted](#output\_storage\_encrypted) | Specifies whether the DB instance is encrypted. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags |
| <a name="output_username"></a> [username](#output\_username) | The master username for the database. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

### Supporting resources:

The example stacks are used by BOLDLink developers to validate the modules by building an actual stack on AWS.

Some of the modules have dependencies on other modules (ex. Ec2 instance depends on the VPC module) so we create them
first and use data sources on the examples to use the stacks.

Any supporting resources will be available on the `tests/supportingResources` and the lifecycle is managed by the `Makefile` targets.

Resources on the `tests/supportingResources` folder are not intended for demo or actual implementation purposes, and can be used for reference.

### Makefile
The makefile contained in this repo is optimized for linux paths and the main purpose is to execute testing for now.
* Create all tests stacks including any supporting resources:
```console
make tests
```
* Clean all tests *except* existing supporting resources:
```console
make clean
```
* Clean supporting resources - this is done separately so you can test your module build/modify/destroy independently.
```console
make cleansupporting
```
* !!!DANGER!!! Clean the state files from examples and test/supportingResources - use with CAUTION!!!
```console
make cleanstatefiles
```
#### BOLDLink-SIG 2023
