# Data source to fetch bastion sg ID from SSM Parameter Store
data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/${var.project_name}/${var.environment}/bastion_sg_id"
}

# Data source to fetch public subnet ids from SSM Parameter Store
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
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
