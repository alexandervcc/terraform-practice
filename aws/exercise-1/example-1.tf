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

// VPC 
resource "aws_vpc" "tf-vpc-v2" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "v2"
  }
}

resource "aws_internet_gateway" "tf-internet-gateway-v2" {
  vpc_id = aws_vpc.tf-vpc-v2.id
}

resource "aws_route_table" "tf-route-table-v2" {
  vpc_id = aws_vpc.tf-vpc-v2.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-internet-gateway-v2.id
  }
}

resource "aws_subnet" "tf-subnet-v2" {
  vpc_id = aws_vpc.tf-vpc-v2.id
  cidr_block = "10.0.1.0/24"

  availability_zone = "us-east-2a"
}