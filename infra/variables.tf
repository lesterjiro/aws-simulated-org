variable "aws_region" {
  description = "Which AWS region resources will live in"
  type        = string
  default     = "ap-southeast-1"
}

variable "env" {
  description = "Environment label (root, dev, prod)"
  type        = string
  default     = "root"
}

variable "env_map" {
  description = "Map environment labels for reference"
  type        = map(string)
  default = {
    root = "root"
    dev  = "dev"
    prod = "prod"
  }
}

variable "budget_limit" {
  description = "Budget limit per environment (USD per month)"
  type        = map(number)
  default = {
    root = 5
    dev  = 10
    prod = 15
  }
}

locals {
  common_tags = {
    owner       = "lester"
    project     = "aws-simulated-org"
    environment = var.env
  }

  active_budget_limit = var.budget_limit[var.env]
}

variable "iam_boundary_policy_name" {
  description = "Refers to an IAM permission boundary policy"
  type        = string
  default     = "SimulatedBoundaryPolicy"
}
