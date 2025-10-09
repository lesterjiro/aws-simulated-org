locals {
  # Tagging and Region Configuration
  required_tags   = ["Environment", "Owner", "CostCenter"]
  allowed_regions = ["ap-southeast-1", "ap-northeast-1"]

  # Policy Metadata and Defaults
  policy_prefix = "guardrail-"
  policy_description = {
    tag_enforcement           = "Deny resource creation without required tags"
    region_restriction        = "Deny actions in disallowed regions"
    protect_critical_services = "Prevent deletion of logging or monitoring services"
  }
  effect  = "Deny"
  version = "2012-10-17"

  # Security Boundaries and Protected Services 
  critical_services = ["cloudtrail.amazonaws.com", "config.amazonaws.com", "guardduty.amazonaws.com", "securityhub.amazonaws.com", "cloudwatch.amazonaws.com"]
  env_boundaries    = { dev = "guardrail-boundary_dev", prod = "guardrail-boundary_prod" }
}

data "aws_iam_policy_document" "tag_enforcement" {
  statement {
    sid = "EnforceRequiredTags"

    actions = [
      "ec2:RunInstances",
      "s3:CreateBucket",
      "rds:CreateDBInstance",
      "lambda:CreateFunction",
      "cloudformation:CreateStack",
      "iam:CreateRole",
      "iam:CreateUser"
    ]

    resources = ["*"]
    effect    = local.effect

    # Dynamic block for each required tag
    dynamic "condition" {
      for_each = toset(local.required_tags)
      content {
        test     = "Null"
        variable = "aws:RequestTag/${condition.value}"
        values   = ["true"]
      }
    }
  }
}

data "aws_iam_policy_document" "region_restriction" {
  statement {
    sid = "RegionRestriction"

    actions = [
      "ec2:RunInstances",
      "s3:CreateBucket",
      "rds:CreateDBInstance",
      "lambda:CreateFunction",
      "cloudformation:CreateStack",
      "iam:CreateRole",
      "iam:CreateUser"
    ]

    resources = ["*"]
    effect    = local.effect

    condition {
      test = "StringNotEquals"
      variable = "aws:RequestedRegion"
      values = local.allowed_regions
    } 
  }
}

data "aws_iam_policy_document" "protect_critical_services" {
  statement {
    sid = "ProtectCriticalServices"

    actions = [
      "cloudtrail:DeleteTrail",
      "cloudtrail:StopLogging",
      "cloudtrail:UpdateLogging",
      "config:DeleteConfigurationRecorder",
      "config:StopConfigurationRecorder",
      "config:DeleteDeliveryChannel",
      "guardduty:DeleteDetector",
      "guardduty:StopMonitoringMembers",
      "guardduty:UpdateDetector",
      "securityhub:DisableSecurityHub",
      "securityhub:DeleteInvitations",
      "securityhub:DissassociateFromMasterAccount",
      "cloudwatch:DeleteLogGroup",
      "cloudwatch:DeleteAlarms",
      "cloudwatch:PutMetricFilter"
    ]

    resources = ["*"]
    effect = local.effect
  }
}
