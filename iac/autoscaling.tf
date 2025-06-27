module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.4.1"

  name                 = "lab-asg"
  min_size             = 0
  max_size             = 1
  desired_capacity     = 1
  health_check_type    = "EC2"
  vpc_zone_identifier  = [module.vpc.private_subnets[0]]

  launch_template_name = "lab-launch-template"
  image_id             = "ami-05ffe3c48a9991133" 
  instance_type        = "t3.micro"

  user_data = base64encode(<<-EOF
          #!/bin/bash
          set -e

          # Update packages
          yum update -y

          # --- Install NGINX ---
          amazon-linux-extras enable nginx1 -y
          yum install -y nginx
          systemctl enable nginx
          systemctl start nginx

          # --- Install CodeDeploy Agent ---
          yum install -y ruby wget

          cd /home/ec2-user

          wget https://aws-codedeploy-${AWS_REGION}.s3.${AWS_REGION}.amazonaws.com/latest/install
          chmod +x ./install

          ./install auto

          systemctl enable codedeploy-agent
          systemctl start codedeploy-agent

          # Optional: Check status
          systemctl status codedeploy-agent || true
    EOF
  )

  tags = {
    Name        = "lab-instance"
    Environment = "lab"
  }
}
