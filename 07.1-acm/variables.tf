# Variable to define a variable with the project name.
variable "project_name" {
  default = "expense"
}

# Variable to define a variable with the environment name.
variable "environment" {
  default = "dev"
}

# Variable to define a common tags of the security group.
variable "common_tags" {
  default = {
    Project     = "Expense"
    Environment = "Dev"
    Terraform   = "True"
  }
}

# Variable to store the vpn sg rules.
variable "vpn_sg_rules" {
  default = [
    {
      from_port   = 943
      to_port     = 943
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 1194
      to_port     = 1194
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# Variable to store the zone id.
variable "zone_id" {
  default = "Z046237833AJ59NBNDCY"
}
