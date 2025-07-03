# resource "aws_codedeploy_app" "webapp" {
#   compute_platform = "Server"
#   name             = "CodeDeployAppNameWithASG"
# }

# # CodeDeploy Deployment Group
# resource "aws_codedeploy_deployment_group" "webapp" {
#   app_name              = aws_codedeploy_app.webapp.name
#   deployment_group_name = "CodeDeployGroupName"
#   service_role_arn      = aws_iam_role.codedeploy_role.arn

#   deployment_config_name = "CodeDeployDefault.OneAtATime"

#   auto_rollback_configuration {
#     enabled = true
#     events  = ["DEPLOYMENT_FAILURE", "DEPLOYMENT_STOP_ON_REQUEST"]
#   }

#   auto_scaling_groups = [module.asg.autoscaling_group_name]
# }