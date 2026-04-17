# Local to store the 1st subnet private subnet id.
locals {
  private_subnet_id = element(split(",", data.aws_ssm_parameter.private_subnet_ids.value), 0)
}
