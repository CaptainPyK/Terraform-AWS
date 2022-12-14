terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = local.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}