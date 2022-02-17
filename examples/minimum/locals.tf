locals {
  vpc_id = data.aws_vpc.supporting.id
  tags   = merge({ "Name" = var.db_name }, var.tags)
  database_subnets = [
    for s in data.aws_subnet.database : s.id
  ]
}
