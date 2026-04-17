# Data source to fetch frontend sg ID from SSM Parameter Store
data "aws_ssm_parameter" "frontend_sg_id" {
  name = "/${var.project_name}/${var.environment}/frontend_sg_id"
}

# Data source to fetch public subent ids from SSM Parameter Store
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

# Data source to fetch web alb listener arn from SSM Parameter Store
data "aws_ssm_parameter" "web_alb_listener_arn_https" {
  name = "/${var.project_name}/${var.environment}/web_alb_listener_arn_https"
}

# Data source to fetch vpc id from SSM Parameter Store
data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
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
