[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/boldlink/terraform-aws-rds/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-rds.svg)](https://github.com/boldlink/terraform-aws-rds/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-rds/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-rds/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# Terraform module usage example with postgreSQL configuration  

### Running this example
The makefile contained in this example is optimized for linux paths and the main purpose is to run this example stack including creating supporting resources.

```console
make tests
```
* Clean example stack & supporting resources:
```console
make tfdestroy
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.15.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds_instance_postgres"></a> [rds\_instance\_postgres](#module\_rds\_instance\_postgres) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [random_password.rds_pwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.rds_usr](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_iam_policy_document.monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_alias.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_subnet.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.supporting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | Create an IAM role for enhanced monitoring | `bool` | `true` | no |
| <a name="input_create_option_group"></a> [create\_option\_group](#input\_create\_option\_group) | whether to create option\_group resource or not | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create a Security Group for RDS cluster. | `bool` | `true` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false. | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to enable for exporting to CloudWatch logs. | `list(string)` | <pre>[<br>  "postgresql",<br>  "upgrade"<br>]</pre> | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine to use. | `string` | `"postgres"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Specify the version of the engine for this db | `string` | `"14.1"` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled | `bool` | `true` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance class for your instance(s). | `string` | `"db.t4g.large"` | no |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | Specify the major version of the engine that this option group should be associated with. | `string` | `"14"` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | The upper limit to which Amazon RDS can automatically scale the storage of the DB instance. | `number` | `25` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. | `number` | `30` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Boolean if specified leave availability\_zone empty, default = false | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The stack name | `string` | `"exampleinstancepostgresql"` | no |
| <a name="input_port"></a> [port](#input\_port) | Port through which db accepts traffic | `number` | `5432` | no |
| <a name="input_supporting_resources_name"></a> [supporting\_resources\_name](#input\_supporting\_resources\_name) | The stack name for supporting resources launched separately | `string` | `"terraform-aws-rds"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The resource tags to be applied | `map(string)` | <pre>{<br>  "Department": "DevOps",<br>  "Environment": "example",<br>  "InstanceScheduler": true,<br>  "LayerId": "Example",<br>  "LayerName": "Example",<br>  "Owner": "hugo.almeida",<br>  "Project": "Examples",<br>  "user::CostCenter": "terraform-registry"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
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

#### BOLDLink-SIG 2023
