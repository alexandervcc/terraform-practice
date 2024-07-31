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

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-internet-gateway-v2.id
  }
}

resource "aws_subnet" "tf-subnet-v2" {
  vpc_id     = aws_vpc.tf-vpc-v2.id
  cidr_block = "10.0.1.0/24"

  availability_zone = "us-east-2a"
}


// Associate subnet with route table
resource "aws_route_table_association" "tf-subnet--route-table--v2" {
  route_table_id = aws_subnet.tf-subnet-v2.id
  subnet_id      = aws_subnet.tf-subnet-v2.id
}

resource "aws_security_group" "tf-security-group--web-traffic" {
  vpc_id = aws_vpc.tf-vpc-v2.id
  name   = "Allow web traffic"
}

resource "aws_vpc_security_group_ingress_rule" "tf-sg-rule--https" {
  security_group_id = aws_security_group.tf-security-group--web-traffic.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "tf-sg-rule--http" {
  security_group_id = aws_security_group.tf-security-group--web-traffic.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "tf-sg-rule--ssh" {
  security_group_id = aws_security_group.tf-security-group--web-traffic.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 2
  to_port           = 2
}

resource "aws_vpc_security_group_egress_rule" "tf-sg-rule--out" {
  security_group_id = aws_security_group.tf-security-group--web-traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  # semantically equivalent to all ports
  ip_protocol = "-1"
}

// Assign a private IP
resource "aws_network_interface" "tf-network-interface--v2" {
  subnet_id       = aws_subnet.tf-subnet-v2.id
  private_ip      = "10.0.1.50"
  security_groups = [aws_security_group.tf-security-group--web-traffic.id]
}

// Elastic IP for EC2 instance
resource "aws_eip" "tf-elastic-ip--v2" {
  network_interface         = aws_network_interface.tf-network-interface--v2.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.tf-internet-gateway-v2]
}

resource "aws_instance" "tf-ec2-instance--v2" {
  ami               = "ami-00db8dadb36c9815e"
  instance_type     = "t2.micro"
  availability_zone = "us-east-2a"
  key_name          = "main-test"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.tf-network-interface--v2.id
  }

  // commands for instance
  user_data = <<-EOF
                #!/bin/bash
                sudo apt updat e-y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'Terraform Test > /var/www/html/index.html'
                EOF

}





