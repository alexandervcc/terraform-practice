terraform {
  required_version = "~> 1.9.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.66.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "default"
}
