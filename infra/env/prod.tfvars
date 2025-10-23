# Environment label
env = "prod"

# AWS region
aws_region = "ap-southeast-1"

# Notification email for budgets
notification_emails = { prod = "prod-team@example.com" }

# Budget limit for this environment (USD per month)
budget_limits = { prod = 15 } # matches default value

# Percentage threshold to trigger budget alerts
threshold_percent = 80

# Use anomaly detection in production for better monitoring
use_anomaly_detection = true

# Common tags (it's optional to override)
common_tags = {
  owner       = "lester"
  project     = "aws-simulated-org"
  environment = "prod"
}
