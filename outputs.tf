output "address" {
  value       = aws_db_instance.main.address
  description = "The hostname of the RDS instance. See also endpoint and port"
}

output "arn" {
  value       = aws_db_instance.main.arn
  description = "The ARN of the RDS instance."
}

output "allocated_storage" {
  value       = aws_db_instance.main.allocated_storage
  description = "The amount of allocated storage."
}


output "availability_zone" {
  value       = aws_db_instance.main.availability_zone
  description = "The availability zone of the instance."
}

output "backup_retention_period" {
  value       = aws_db_instance.main.backup_retention_period
  description = "The backup retention period."
}

output "backup_window" {
  value       = aws_db_instance.main.backup_window
  description = "The backup window."
}

output "ca_cert_identifier" {
  value       = aws_db_instance.main.ca_cert_identifier
  description = " Specifies the identifier of the CA certificate for the DB instance."
}

output "endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "The connection endpoint in address:port format."
}

output "engine" {
  value       = aws_db_instance.main.engine
  description = "The database engine."
}

output "engine_version_actual" {
  value       = aws_db_instance.main.engine_version
  description = "The running version of the database."
}

output "hosted_zone_id" {
  value       = aws_db_instance.main.hosted_zone_id
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)."
}

output "id" {
  value       = aws_db_instance.main.id
  description = "The RDS instance ID."
}

output "instance_class" {
  value       = aws_db_instance.main.instance_class
  description = "The RDS instance class."
}

output "maintenance_window" {
  value       = aws_db_instance.main.maintenance_window
  description = "The instance maintenance window."
}

output "multi_az" {
  value       = aws_db_instance.main.multi_az
  description = "If the RDS instance is multi AZ enabled."
}

output "name" {
  value       = aws_db_instance.main.name
  description = "The database name."
}

output "port" {
  value       = aws_db_instance.main.port
  description = "The database port."
}

output "resource_id" {
  value       = aws_db_instance.main.resource_id
  description = "The RDS Resource ID of this instance."
}

output "status" {
  value       = aws_db_instance.main.status
  description = "The RDS instance status."
}

output "storage_encrypted" {
  value       = aws_db_instance.main.storage_encrypted
  description = "Specifies whether the DB instance is encrypted."
}

output "username" {
  value       = aws_db_instance.main.username
  description = "The master username for the database."
}