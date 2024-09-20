module "aws-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = "t3-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  database_subnets                       = ["10.0.151.0/24", "10.0.152.0/24"]
  create_database_internet_gateway_route = false
  create_database_nat_gateway_route      = false

  enable_nat_gateway = true
  # One for each availability zone
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true


  vpc_tags = {
    Name = "dev"
  }
  public_subnet_tags = {
    Name = "public-subnet"
  }
  private_subnet_tags = {
    Name = "private-subnet"
  }
  database_subnet_tags = {
    Name = "database-subnet"
  }

}
