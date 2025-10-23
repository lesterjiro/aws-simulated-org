# Environment label
env = "dev"

# AWS region
aws_region = "ap-southeast-1"

# Notification email for budgets
notification_emails = { dev = "dev-team@example.com" }

# Budget limit for this environment (USD per month)
budget_limits = { dev = 10 } # matches defualt value

# Percentage threshold to trigger budget alerts
threshold_percent = 80

# Use anomaly detection (optional, faster testing for dev)
use_anomaly_detection = false

# Common tags (it's optional to override)
common_tags = {
  owner       = "lester"
  project     = "aws-simulated-org"
  environment = "dev"
}
