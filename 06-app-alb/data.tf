# Data source to fetch App ALB sg ID from SSM Parameter Store
data "aws_ssm_parameter" "app_alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/app_alb_sg_id"
}

# Data source to fetch private subnet ids from SSM Parameter Store
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

# Data source to get the default vpc id in the given region.
data "aws_vpc" "def_vpc_id" {
  default = true
}
