terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }
  }

  backend "s3" {
    bucket         = "expense-project-state"
    key            = "expense-project-infra-vpc-state-file"
    region         = "us-east-1"
    dynamodb_table = "expense-project-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}
