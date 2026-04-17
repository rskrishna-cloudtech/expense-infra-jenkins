# Data source to fetch VPN sg ID from SSM Parameter Store
data "aws_ssm_parameter" "vpn_sg_id" {
  name = "/${var.project_name}/${var.environment}/vpn_sg_id"
}

# Data source to fetch private subent ids from SSM Parameter Store
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

# Data source to fetch public subnet ids from SSM Parameter Store
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

# Data source to get the ami id.
data "aws_ami" "ami_info" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-fe8020db*"]
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
