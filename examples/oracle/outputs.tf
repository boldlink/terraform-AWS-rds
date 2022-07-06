output "address" {
  value = [
    module.rds_instance_oracle,
  ]
  description = "Values for resources created by the module"
}
