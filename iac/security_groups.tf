module "sg_alb" {
  source              = "github.com/terraform-aws-modules/terraform-aws-security-group.git//.?ref=v4.6.1"
  name                = "${local.name_prefix}-alb-sg"
  vpc_id              = module.vpc.vpc_id
  description         = "Security group for ${local.name_prefix} load balancer"
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]



  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]

  tags = merge(
    {
      Name = "alb-sg"
    },
    local.common_tags
  )
}

module "sg_ec2" {
  source                  = "github.com/terraform-aws-modules/terraform-aws-security-group.git//.?ref=v4.6.1"
  name                    = "${local.name_prefix}-ec2-sg"
  vpc_id                  = module.vpc.vpc_id
  description             = "Security group for ${local.name_prefix} EC2 instances"
  ingress_rules           = ["http-80-tcp"]
  ingress_security_groups = [module.sg_alb.security_group_id]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = [""]
  tags = merge(
    {
      Name = "ec2-sg"
    },
    local.common_tags
  )
}