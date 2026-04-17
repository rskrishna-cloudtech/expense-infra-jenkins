# Module to create the SG for DB instance. Removed ansible modules as we are following pull based model.
module "db" {
  # source         = "../../terraform-practice/terraform-aws-securitygroup"
  source         = "git::https://github.com/rskrishna-cloudtech/terraform-practice.git//terraform-aws-securitygroup?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for DB MySQL Instance"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_name        = "db"
}

# Module to create the SG for backend instance.
module "backend" {
  # source         = "../../terraform-practice/terraform-aws-securitygroup"
  source         = "git::https://github.com/rskrishna-cloudtech/terraform-practice.git//terraform-aws-securitygroup?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for Backend Instance"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_name        = "backend"
}

# Module to create the SG for app_alb instance.
module "app_alb" {
  # source         = "../../terraform-practice/terraform-aws-securitygroup"
  source         = "git::https://github.com/rskrishna-cloudtech/terraform-practice.git//terraform-aws-securitygroup?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for app_alb Instance"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_name        = "app_alb"
}

# Module to create the SG for frontend instance.
module "frontend" {
  # source         = "../../terraform-practice/terraform-aws-securitygroup"
  source         = "git::https://github.com/rskrishna-cloudtech/terraform-practice.git//terraform-aws-securitygroup?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for Frontend Instance"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_name        = "frontend"
}

# Module to create the SG for web alb instance.
module "web_alb" {
  # source         = "../../terraform-practice/terraform-aws-securitygroup"
  source         = "git::https://github.com/rskrishna-cloudtech/terraform-practice.git//terraform-aws-securitygroup?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for Web ALB  Instance"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_name        = "web-alb"
}

# Module to create the SG for bastion instance.
module "bastion" {
  # source         = "../../terraform-practice/terraform-aws-securitygroup"
  source         = "git::https://github.com/rskrishna-cloudtech/terraform-practice.git//terraform-aws-securitygroup?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for bastion Instance"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_name        = "bastion"
}

# Module to create the SG for VPN instance.
module "vpn" {
  # source         = "../../terraform-practice/terraform-aws-securitygroup"
  source         = "git::https://github.com/rskrishna-cloudtech/terraform-practice.git//terraform-aws-securitygroup?ref=main"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for VPN Instance"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  sg_name        = "vpn"
  inbound_rules  = var.vpn_sg_rules
}

# Resource to create the inbound rule for DB security group to access traffic from backend.
resource "aws_security_group_rule" "db_backend" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.backend.sg_id
  security_group_id        = module.db.sg_id
}

# Resource to create the inbound rule for DB security group to access traffic from bastion.
resource "aws_security_group_rule" "db_bastion" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.db.sg_id
}

# Resource to create the inbound rule for DB security group to access traffic from vpn.
resource "aws_security_group_rule" "db_vpn" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.db.sg_id
}

# Resource to create the inbound rule for backend security group to access traffic from app alb.
resource "aws_security_group_rule" "backend_app_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb.sg_id
  security_group_id        = module.backend.sg_id
}

# Resource to create the inbound rule for backend security group to access traffic from bastion.
resource "aws_security_group_rule" "backend_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.backend.sg_id
}

# Resource to create the inbound rule for backend security group to access traffic from vpn through ssh.
resource "aws_security_group_rule" "backend_vpn_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.backend.sg_id
}

# Resource to create the inbound rule for backend security group to access traffic from vpn through http.
resource "aws_security_group_rule" "backend_vpn_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.backend.sg_id
}

# Resource to create the inbound rule for app alb security group to access traffic from vpn
resource "aws_security_group_rule" "app_alb_vpn" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.app_alb.sg_id
}

# Resource to create the inbound rule for app alb security group to access traffic from bastion
resource "aws_security_group_rule" "app_alb_bastion" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.app_alb.sg_id
}

# Resource to create the inbound rule for app alb security group to access traffic from frontend
resource "aws_security_group_rule" "app_alb_frontend" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.app_alb.sg_id
}

# Resource to create the inbound rule for backend security group to access traffic from web alb.
resource "aws_security_group_rule" "frontend_web_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.web_alb.sg_id
  security_group_id        = module.frontend.sg_id
}

# Resource to create the inbound rule for backend security group to access traffic from bastion.
resource "aws_security_group_rule" "frontend_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.frontend.sg_id
}

# Resource to create the inbound rule for backend security group to access traffic from vpn.
resource "aws_security_group_rule" "frontend_vpn" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.frontend.sg_id
}

# Resource to create the inbound rule for web alb security group to access traffic from public with http.
resource "aws_security_group_rule" "web_alb_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web_alb.sg_id
}

# Resource to create the inbound rule for web alb security group to access traffic from public with https.
resource "aws_security_group_rule" "web_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web_alb.sg_id
}

# Resource to create the inbound rule for bastion security group to access traffic from public or internet.
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

# Resource to create the inbound rule for frontend to access traffic from public or internet.
resource "aws_security_group_rule" "frontend_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend.sg_id
}
