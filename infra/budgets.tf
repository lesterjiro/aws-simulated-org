locals {
  environments = {
    dev = {
      tag_value    = "Dev"
      limit_amount = var.budget_limits["dev"]
      threshold    = var.threshold_percent
    }

    prod = {
      tag_value    = "Prod"
      limit_amount = var.budget_limits["prod"]
      threshold    = var.threshold_percent
    }
  }
}

resource "aws_budgets_budget" "monthly_budget_env" {
  for_each = local.environments
   
  name              = "${each.key}-monthly-budget-${var.project_name}"  
  budget_type       = "COST"
  time_period_start = "2025-10-01_00:00"
  time_period_end = "2087-06-15_00:00"
  time_unit         = var.time_unit
  limit_amount      = each.value.limit_amount 
  limit_unit        = "USD"

  cost_filter {
    name   = "TagKeyValue" 
    values = ["${var.tag_key}$${each.value.tag_value}"] 
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = each.value.threshold
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.notification_emails[each.key]]
  }
}

resource "aws_ce_anomaly_monitor" "org_cost_monitor" {
  name              = "org-cost-monitor"
  monitor_type      = "DIMENSIONAL"
  monitor_dimension = "SERVICE"
}

resource "aws_ce_anomaly_subscription" "org_cost_alert" {
  frequency = "DAILY"

  monitor_arn_list = [
    aws_ce_anomaly_monitor.org_cost_monitor.arn
  ]

  threshold_expression {
    dimension {
      key           = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"
      match_options = ["GREATER_THAN_OR_EQUAL"]
      values        = [tostring(var.threshold_percent)]
    }
  }

  subscriber {
    type    = "EMAIL"
    address = var.notification_emails[0]
  }
}
