module "sg-private" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = var.sg-private-name
  description = var.sg-private-description

  vpc_id = module.aws-vpc.vpc_id

  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.aws-vpc.vpc_cidr_block]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Name = "sg-private"
  }
}
