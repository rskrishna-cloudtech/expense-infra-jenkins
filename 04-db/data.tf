# Data source to fetch DB sg ID from SSM Parameter Store
data "aws_ssm_parameter" "db_sg_id" {
  name = "/${var.project_name}/${var.environment}/db_sg_id"
}

# Data source to fetch DB subnet group name from SSM Parameter Store
data "aws_ssm_parameter" "db_subnet_group_name" {
  name = "/${var.project_name}/${var.environment}/db_subnet_group_name"
}
