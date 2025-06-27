variable "environment_variables" {
  description = "Environment variables"
  type = object({
    environment = string
    project     = string
  })
}

variable "vpc_settings" {
  description = "All VPC-related settings"
  type = object({
    vpc_cidr             = string
    vpc_azs              = list(string)
    private_subnets      = list(string)
    public_subnets       = list(string)
    enable_nat_gateway   = bool
    single_nat_gateway   = bool
    enable_dns_hostnames = bool
    enable_dns_support   = bool
  })
}

variable "ec2_settings" {
  description = "EC2-related settings"
  type = object({
    instance_type = string
  })
}