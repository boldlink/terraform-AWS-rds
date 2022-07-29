# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- feat: use s3 module to create the bucket in example.

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
- feat: subnetgroup modification
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
- fix: removed depricated data resources, updated source link && added example readme
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

[Unreleased]: https://github.com/boldlink/terraform-aws-rds/compare/1.0.9...HEAD

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
