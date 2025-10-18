variable "project_name" {
  description = "Specifies the name of the overall project"
  type        = string
  default     = "aws-simulated-org"
}

variable "aws_region" {
  description = "Which AWS region resources will live in"
  type        = string
  default     = "ap-southeast-1"
}

variable "env" {
  description = "Environment label (root, dev, prod)"
  type        = string
  default     = "dev"
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

variable "budget_limits" {
  description = "Budget limit per environment (USD per month)"
  type        = map(number)
  default = {
    root = 5
    dev  = 10
    prod = 15
  }
}

variable "notification_emails" {
  description = "Environment-specific notification emails"
  type        = map(string)
  default     = {
    dev   = "dev-team@example.com"
    prod  = "prod-team@example.com"
  }
}

variable "threshold_percent" {
  description = "The percentage of the monthly budget at which an alert should trigger"
  type        = number
  default     = 80
}

variable "time_unit" {
  description = "Defines how often the budget resets and evaluates spending"
  type        = string
  default     = "MONTHLY" # Can be MONTHLY, QUARTERLY or ANNUALLY.
}

variable "tag_key" {
  description = "The name of the tag used to group costs per environment"
  type        = string
  default     = "Environment"
}

variable "tag_values" {
  description = "The list of environment values under the chosen tag key"
  type        = list(string)
  default     = ["root", "dev", "prod"]
}

variable "use_anomaly_detection" {
  description = "Toggle that decides whether to create AWS Cost Anomaly Detection resources"
  type        = bool
  default     = false # true enables anomaly monitoring; false disables it for faster testing 
}

variable "anomaly_threshold" {
  description = "Percentage threshold for cost anomaly alerts."
  type        = number
  default     = 20
}

locals {
  common_tags = {
    owner       = "lester"
    project     = "aws-simulated-org"
    environment = var.env
  }

  active_budget_limit = var.budget_limits[var.env]
}
