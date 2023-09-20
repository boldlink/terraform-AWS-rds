# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- feat: Remove the option to use the VPC default security group.
- feat: Add an option to make `var.db_name = null` when MSSQL engine is selected.
- feat: Add a default security group rule for the port specific to the DB engine selected allowing private subnets to access the DB (must be overidable by input).
- fix: CKV2_AWS_60 #"Ensure RDS instance with copy tags to snapshots is enabled"
- fix: CKV_AWS_293 #"Ensure that AWS database instances have deletion protection enabled
- fix: CKV_AWS_157 #"Ensure that RDS instances have Multi-AZ enabled"
- fix: CKV_AWS_118 #"Ensure that enhanced monitoring is enabled for Amazon RDS instances"
- fix: CKV_AWS_161 #"Ensure RDS database has IAM authentication enabled"
- fix: CKV2_AWS_5 #"Ensure that Security Groups are attached to another resource"
- feat: Show usage of parameter group in examples
- fix: upgrade s3 module version used in s3-import example.

## [1.4.0] - 2023-09-20

- feat: added manage_master_user_password and master_user_secret_kms_key_id arguments
- removed random_password resources in all examples.

## [1.3.0] - 2023-08-16
### Changes
- feat: Separate the inputs of name of the instance from the db name input, this is a breaking change since now `var.db_name` is mandatory.
- feat: Set the `var.create_security_group = true` by default to prevent using the default VPC security group.
- feat: Add security group config to all examples.
- feat: Set var.db_name = null in MSSQL engine example.

## [1.2.0] - 2023-06-06
### Changes
- fix: CKV2_AWS_30 #"Ensure Postgres RDS as aws_db_instance has Query Logging enabled"
- feat: Added aws_db_parameter_group resource
- feat: use s3 module to create the bucket in example.
- fix: s3 import example checkov alerts for s3
- feat: moved static values to variables.tf

## [1.1.2] - 2022-10-19
### Changes
- update: `.gitignore file` to except terraform, tflint and terraform docs zip files from being committed
- update: removed badges with .yml extension

## [1.1.1] - 2022-10-14
### Changes
- fix: an empty vpc_security_group_ids and `var.create_security_group == false` always triggers change in place for a second terraform apply
- Updated github workflow files
- Updated Module Makefile
- Added makefiles for examples
- updated tags variable for values to be populated at the stack level
- Added vpc as a supporting resource

## [1.1.0] - 2022-07-30
- fix: db instance security group ids argument
- added: security group arn and id in outputs

## [1.0.9] - 2022-07-06
### Changes
- Added the `.github/workflow` folder (not supposed to run gitcommit)
- Added `CHANGELOG.md`
- Added `CODEOWNERS`
- Added `versions.tf`, which is important for pre-commit checks
- Added `Makefile` for examples automation
- Added `.gitignore` file
- feat: used custom vpc for the examples

## [1.0.8] - 2022-04-21
### Changes
- feat: mariadb engine & mysql import from s3 working examples.

## [1.0.7] - 2022-04-05
### Changes
- feat: module upgrade & added multiple examples

## [1.0.6] - 2022-04-04
### Changes
- feat: removed old example folder

## [1.0.5] - 2022-04-01
### Changes
- fix: rectified typo
- feat: Module upgrade
- feat: subnet-group modification
- feat: tested with mysql example
- feat: option group && enhanced monitoring
- feat: updated repository code

## [1.0.4] - 2022-03-31
### Changes
- fix: minor fixes
- fix: pre-commit checks fix
- feat: Module restructuring

## [1.0.3] - 2022-02-28
### Changes
- fix: minor fixes
- fix: removed deprecated data resources, updated source link && added example readme
- feat: pre-commit checks fix
- feat: updated repository code
- feat: subnet group update

## [1.0.2] - 2022-02-17
### Changes
- fix: pre-commit checks fix
- fix: minor fixes
- updated repository code
- feat: Added example url

## [1.0.0] - 2021-12-22
### Description
- Initial commit
- pre-commit checks fix

[Unreleased]: https://github.com/boldlink/terraform-aws-rds/compare/1.4.0...HEAD

[1.0.0]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.0.0
[1.0.2]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.0.2
[1.0.3]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.0.3
[1.0.4]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.0.4
[1.0.5]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.0.5
[1.0.6]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.0.6
[1.0.7]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.0.7
[1.0.8]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.0.8
[1.0.9]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.0.9
[1.1.0]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.1.0
[1.1.1]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.1.1
[1.1.2]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.1.2
[1.2.0]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.2.0
[1.3.0]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.3.0
[1.4.0]: https://github.com/boldlink/terraform-aws-rds/releases/tag/1.4.0