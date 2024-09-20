module "aws-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = local.vpc-name
  cidr = "10.0.0.0/16"

  azs             = var.azs
  private_subnets = var.private-subnets
  public_subnets  = var.public-subnets

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
    Name = local.vpc-name
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
