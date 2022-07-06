output "mysql" {
  value = [
    module.rds_instance_mysql,
  ]
  description = "Output values for the module"
}
