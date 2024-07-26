// Pterovider: specify API to talk, for this file to AWS API
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

// Create a resource
resource "aws_instance" "tf-ec2-t1" {
  ami           = "ami-00db8dadb36c9815e"
  instance_type = "t2.micro"
}