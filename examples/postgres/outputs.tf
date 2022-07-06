output "address" {
  value = [
    module.rds_instance_postgres,
  ]
  description = "Values for resources created by the module"
}
