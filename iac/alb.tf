module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.6.1"

  name               = "alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets

  security_groups            = [module.sg_alb.security_group_id]
  enable_deletion_protection = false

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      target_group_index = 0
      ssl_policy         = "ELBSecurityPolicy-2016-08"
      certificate_arn    = module.acm_alb.acm_certificate_arn
    }
  ]

  target_groups = [
    {
      name_prefix      = "alb-tg"
      backend_protocol = "HTTP"
      backend_port     = var.ecs_settings.container_port
      target_type      = "ip"
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
