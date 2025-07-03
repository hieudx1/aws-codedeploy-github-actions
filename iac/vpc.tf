module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git//.?ref=v4.0.2"

  name            = "${local.name_prefix}-vpc"
  cidr            = var.vpc_settings.vpc_cidr
  azs             = var.vpc_settings.vpc_azs
  public_subnets  = var.vpc_settings.public_subnets

  enable_nat_gateway = try(var.vpc_settings.enable_nat_gateway, "false")
  single_nat_gateway = try(var.vpc_settings.single_nat_gateway, "true")

  # Enable DNS hostnames and DNS support
  enable_dns_hostnames = var.vpc_settings.enable_dns_hostnames
  enable_dns_support   = var.vpc_settings.enable_dns_support
  tags = merge(
    {
      Name = "${local.name_prefix}-vpc"
    },
    local.common_tags
  )
}
