output "address" {
  value = [
    module.rds_instance_mariadb,
  ]
  description = "Output values for the module"
}
