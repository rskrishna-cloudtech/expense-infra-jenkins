# Data source to fetch VPN sg ID from SSM Parameter Store
data "aws_ssm_parameter" "backend_sg_id" {
  name = "/${var.project_name}/${var.environment}/backend_sg_id"
}

# Data source to fetch private subent ids from SSM Parameter Store
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

# Data source to fetch vpc id from SSM Parameter Store
data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

# Data source to fetch app_alb_listener from SSM Parameter Store
data "aws_ssm_parameter" "app_alb_listener_arn" {
  name = "/${var.project_name}/${var.environment}/app_alb_listener_arn"
}

# Data source to get the ami id.
data "aws_ami" "ami_info" {
  most_recent = true
  owners      = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Data source to get the default vpc id in the given region.
data "aws_vpc" "def_vpc_id" {
  default = true
}
