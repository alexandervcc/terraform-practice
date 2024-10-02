module "alb-http" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.11.0"

  name    = "alb-http-${var.environment}"
  vpc_id  = module.aws-vpc.vpc_id
  subnets = module.aws-vpc.public_subnets

  load_balancer_type = "application"
  security_groups    = [module.sg-load-balancer-http.security_group_id]

  target_groups = {
    tg-private-instances = {
      name_prefix                       = "prvec2"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = true
      protocol_version                  = "HTTP1"

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      # Avoid automatic creation and specific through a resource below.
      create_attachment = false
    }
  }

  listeners = {
    public-ig-to-private-instances = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "tg-private-instances"
      }
    }
  }
}

resource "aws_lb_target_group_attachment" "alb-tg-private-attachments" {
  for_each = { for instance, details in module.ec2-private-instance : instance => details }

  target_group_arn = module.alb-http.target_groups["tg-private-instances"].arn
  target_id        = each.value.id
  port             = 80
}
