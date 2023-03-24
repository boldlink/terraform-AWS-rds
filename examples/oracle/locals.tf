locals {
  vpc_id    = data.aws_vpc.supporting.id
  partition = data.aws_partition.current.partition
  tags      = merge({ "Name" = var.name }, var.tags)

  database_subnets = [
    for s in data.aws_subnet.database : s.id
  ]
}
