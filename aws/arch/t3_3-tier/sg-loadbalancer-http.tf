module "sg-load-balancer-http" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = "sec-grp--load-balancer-http"
  description = "SG for load balancer to allow HTTP communication."

  vpc_id = module.aws-vpc.vpc_id

  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  ingress_with_cidr_blocks = [{
    from_port   = 81
    to_port     = 81
    protocol    = 6
    description = "HTTP through port 81"
    cidr_blocks = "0.0.0.0/0"

  }]


  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Name = "sg-load-balancer"
  }
}
