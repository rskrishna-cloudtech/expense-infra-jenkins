# Terraform module to call source resource file.
module "aws-vpc" {

  # Calling terraform-aws-vpc module from relative path.
  # source = "../terraform-practice/terraform-aws-vpc"

  # To get the source file form the github repo.
  # source = "<github-url-of-repo?ref=<git-branch-name>>"
  source = "git::https://github.com/rskrishna-cloudtech/terraform-practice.git//terraform-aws-vpc?ref=main"

  project_name          = var.project_name
  common_tags           = var.common_tags
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  is_peering_required   = var.is_peering_required
}
