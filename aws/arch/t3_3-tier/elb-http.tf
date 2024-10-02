/* 
module "elb-http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "4.0.2"

  name = "elb-http-access-${var.environment}"

  subnets         = module.aws-vpc.public_subnets
  security_groups = [module.sg-load-balancer-http.security_group_id]
  internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 81
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  // ELB attachments
  number_of_instances = length(module.ec2-private-instance)
  instances           = [for inst in module.ec2-private-instance : inst.id]

  tags = {
    Environment = var.environment
  }
}
 */