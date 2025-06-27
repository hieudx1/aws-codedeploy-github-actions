locals {
  common_tags = {
    Environment = var.environment_variables.environment
    Project     = var.environment_variables.project
    SpTeam      = "DevOps"
  }

  name_prefix = "${var.environment_variables.project}-${var.environment_variables.environment}"
}
