# Resource to create a parameter to store the vpc id.
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment}/vpc_id"
  type  = "String"
  value = module.aws-vpc.vpc_id

}

# Resource to create a parameter to store the public subnet ids.
resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/public_subnet_ids"
  type  = "StringList"
  value = join(",", module.aws-vpc.public_subnet_ids) # Converting the list to StringList.

}

# Resource to create a parameter to store the private subnet ids.
resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/private_subnet_ids"
  type  = "StringList"
  value = join(",", module.aws-vpc.private_subnet_ids) # Converting the list to StringList.

}

# Resource to create a parameter to store the db subnet group name.
resource "aws_ssm_parameter" "db_subnet_group_name" {
  name  = "/${var.project_name}/${var.environment}/db_subnet_group_name"
  type  = "String"
  value = module.aws-vpc.database_subnet_group_name
}
