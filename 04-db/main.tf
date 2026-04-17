# Resource module to creeate the RDS.
module "db" {
  source     = "terraform-aws-modules/rds/aws"
  identifier = "${var.project_name}-${var.environment}"

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"

  allocated_storage = 5

  db_name  = "transactions"
  username = "root"
  port     = "3306"

  vpc_security_group_ids = [data.aws_ssm_parameter.db_sg_id.value]

  # DB Subnet group
  db_subnet_group_name = data.aws_ssm_parameter.db_subnet_group_name.value

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}"
    }
  )

  manage_master_user_password = false
  password_wo                 = "ExpenseApp1" # This paramater is changed in the latest version. This is just for testing. In production, use secrets manager or SSM parameter store to manage the password.
  password_wo_version         = 1             # This parameter is added to avoid the error "Error: Error creating RDS instance: InvalidParameterCombination: Cannot specify both MasterUserPassword and MasterUserPasswordWithVersion". This is just for testing. In production, use secrets manager or SSM parameter store to manage the password.
  skip_final_snapshot         = true
}

# Module to create R53 record for RDS instance.
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name

  records = [
    {
      name = "db-${var.environment}.${var.project_name}"
      type = "CNAME"
      ttl  = 1
      records = [
        module.db.db_instance_address
      ]
    }
  ]
}
