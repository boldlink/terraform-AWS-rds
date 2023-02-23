terraform {
  required_version = ">= 0.14.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.15.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.0.0"
    }
  }
}
