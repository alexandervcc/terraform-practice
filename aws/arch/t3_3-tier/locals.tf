locals {
  vpc-name = "t3-vpc-${var.environment}"

  private_subnets = {
    one = module.aws-vpc.private_subnets[0],
    two = module.aws-vpc.private_subnets[1],
  }
}
