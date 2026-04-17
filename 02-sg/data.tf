# Data source to fetch VPC ID from SSM Parameter Store
data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}
