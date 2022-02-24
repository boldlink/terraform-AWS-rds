# complete-mysql

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.2.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds_instance_complete"></a> [rds\_instance\_complete](#module\_rds\_instance\_complete) | boldlink/rds/aws | 1.0.2 |
| <a name="module_rds_instance_external"></a> [rds\_instance\_external](#module\_rds\_instance\_external) | boldlink/rds/aws | 1.0.2 |
| <a name="module_rds_subnet_group"></a> [rds\_subnet\_group](#module\_rds\_subnet\_group) | boldlink/db-subnet-group/aws | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [random_string.rds_pwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.rds_pwd2](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.rds_usr](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.rds_usr2](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_kms_alias.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias) | data source |
| [aws_subnets.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | Example of outputs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
