locals {
  db_name                   = "exampleminimuminstance"
  vpc_id                    = data.aws_vpc.supporting.id
  database_subnets          = local.database_subnet_id
  supporting_resources_name = "terraform-aws-rds"
  database_subnet_id = [
    for s in data.aws_subnet.database : s.id
  ]
  tags = {
    Name        = local.db_name
    Environment = "examples"
  }
}
