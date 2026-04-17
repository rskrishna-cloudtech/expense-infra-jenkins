# Data source to fetch web ALB sg ID from SSM Parameter Store
data "aws_ssm_parameter" "web_alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/web_alb_sg_id"
}

# Data source to fetch public subnet ids from SSM Parameter Store
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

# Data source to fetch acm cerificate arn from SSM Parameter Store
data "aws_ssm_parameter" "acm_certificate_arn" {
  name = "/${var.project_name}/${var.environment}/acm_certificate_arn"
}
