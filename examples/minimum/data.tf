data "aws_vpc" "supporting" {
  filter {
    name   = "tag:Name"
    values = [var.supporting_resources_name]
  }
}

data "aws_subnets" "database" {
  filter {
    name   = "tag:Name"
    values = ["${var.supporting_resources_name}.isolated.*"]
  }
}

data "aws_subnet" "database" {
  for_each = toset(data.aws_subnets.database.ids)
  id       = each.value
}
