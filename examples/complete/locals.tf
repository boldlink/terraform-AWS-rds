locals {
  name             = "exampleinstancemysql"
  vpc_id           = data.aws_vpc.supporting.id
  database_subnets = local.database_subnet_id
  partition        = data.aws_partition.current.partition
  database_subnet_id = [
    for s in data.aws_subnet.database : s.id
  ]
  tags = {
    Environment        = "example"
    Name               = local.name
    "user::CostCenter" = "terraform-registry"
    Department         = "DevOps"
    Project            = "Examples"
    InstanceScheduler  = true
    Owner              = "Boldlink"
    LayerName          = "Example"
    LayerId            = "Example"
  }
}
