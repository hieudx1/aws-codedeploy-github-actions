environment_variables = {
  project     = "webapp01"
  environment = "dev"
  aws_region  = "us-east-1"
}

vpc_settings = {
  vpc_cidr = "10.0.0.0/16"

  vpc_azs = [
    "us-east-1a",
    "us-east-1b",
  ]

  private_subnets = [
    "10.0.1.0/24"
  ]
  public_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]
  enable_nat_gateway   = false
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
}

ec2_settings = {
  instance_type = "t3.micro"
}