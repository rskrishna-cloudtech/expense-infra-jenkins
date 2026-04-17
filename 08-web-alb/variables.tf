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
    Component   = "web-alb"
  }
}

# Variable to store the zone name.
variable "zone_name" {
  default = "rskrishnacloudtech.online"
}
