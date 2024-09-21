module "sg-public-bastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = var.sg-bastion-name
  description = var.sg-bastion-description

  vpc_id = module.aws-vpc.vpc_id

  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Name = "sg-bastion"
  }
}
