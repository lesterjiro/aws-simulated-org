terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "aws-simulated-org-tfstate"
    region       = "ap-southeast-1"
    use_lockfile = true
    encrypt      = true
  }

  required_version = ">=1.5.0"
}

provider "aws" {
  region = "ap-southeast-1"
}
