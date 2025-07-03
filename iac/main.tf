terraform {
  backend "s3" {
    bucket  = "webapp01-terraform-state-bucket"
    key     = "sample-codedeploy/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}