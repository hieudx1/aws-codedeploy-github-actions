module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.4.1"

  name             = "lab-asg"
  min_size         = 1
  max_size         = 1
  desired_capacity = 1

  # Health check thông qua ALB
  health_check_type         = "ELB"
  health_check_grace_period = 300

  # Subnet công khai để instance có thể ra Internet cài CodeDeploy Agent
  vpc_zone_identifier = [module.vpc.public_subnets[0]]

  # Gắn Target Group của ALB
  target_group_arns = [module.alb.target_group_arns[0]]

  # Cấu hình Launch Template
  launch_template_name = "lab-launch-template"
  image_id             = "ami-05ffe3c48a9991133"  # Amazon Linux 2
  instance_type        = "t3.micro"

  # Optional: Security group cho instance
  security_groups = [module.sg_ec2.security_group_id]

  # Cài đặt Nginx và CodeDeploy Agent
  user_data = base64encode(<<-EOF
    #!/bin/bash
    set -e

    # Update
    yum update -y

    # Install nginx
    amazon-linux-extras enable nginx1
    yum install -y nginx
    systemctl enable nginx
    systemctl start nginx

    # Install CodeDeploy Agent
    yum install -y ruby wget
    cd /home/ec2-user
    wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
    chmod +x ./install
    ./install auto
    systemctl enable codedeploy-agent
    systemctl start codedeploy-agent
  EOF
  )

  tags = {
    Name        = "lab-instance"
    Environment = "lab"
  }
}
