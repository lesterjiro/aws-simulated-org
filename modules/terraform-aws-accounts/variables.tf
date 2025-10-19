variable "account_name" {
  description = "Human-readable name of the account (e.g dev, prod, root, audit)"
  type        = string 
}

varibale "account_env" {
  description = "Environment label for this account (e.g dev, prod, root)"
  type        = string
}

variable "account_id" {
  description = "Unique simulated account ID (used for tagging or reference)"
  type        = string
}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
}

variable "project_name" {
  description = "Project name for consistent tagging and naming"
  type        = string
}

variable "common_tags" {
  description = "Base tags merged with environment-specific tags"
  type        = map(string)
}
