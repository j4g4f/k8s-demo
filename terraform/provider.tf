terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  profile    = var.provider_env_profile[terraform.workspace]
}