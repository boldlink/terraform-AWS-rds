provider "aws" {
  region = var.region_1
}

provider "aws" {
  alias  = "dest"
  region = var.region_2
}
