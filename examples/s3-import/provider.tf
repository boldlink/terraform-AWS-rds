provider "aws" {
  region = local.aws_region_1
}

provider "aws" {
  alias  = "dest"
  region = local.aws_region_2
}
