module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.6.1"

  name               = "alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets

  security_groups            = [module.sg_alb.security_group_id]
  enable_deletion_protection = false

  # Listen HTTP 80 → forward đến target group 0
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name_prefix      = "alb-tg"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      health_check = {
        path                = "/"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 3
        unhealthy_threshold = 3
        matcher             = "200"
      }
    }
  ]
}
