terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.5.0"

  #backend "local" {
  #path = "terraform.tfstate"
  #}
}

provider "aws" {
  region = var.aws_region
}
