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
  region     = "us-east-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

// Create a resource
resource "aws_instance" "tf-ec2-t1" {
  ami           = "ami-00db8dadb36c9815e"
  instance_type = "t2.micro"
  tags = {
    origin = "tf"
  }
} 

resource "aws_vpc" "tf-vpc-v1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    origin = "tf",
    date   = "2024-07-28"
  }
}

resource "aws_subnet" "tf-subnet_v1" {
  // specify/reference other resource by the id
  vpc_id     = aws_vpc.tf-vpc-v1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    vpc = "tf-vpc-v1"
  }
}





