locals {
  policy_description = {
    tag_enforcement           = "Deny resource creation without required tags"
    region_restriction        = "Deny actions in disallowed regions"
    protect_critical_services = "Prevent deletion of logging or monitoring services"
  }
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
      "iam:CreateUser",
    ]
    resources = ["*"]
    effect    = var.effect

    # Dynamic block for each required tag
    dynamic "condition" {
      for_each = toset(var.required_tags)
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
    sid       = "RegionRestriction"
    actions   = data.aws_iam_policy_document.tag_enforcement.statement[0].actions
    resources = ["*"]
    effect    = var.effect

    condition {
      test     = "StringNotEquals"
      variable = "aws:Region"
      values   = var.allowed_regions
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
      "securityhub:DisassociateFromMasterAccount",
      "cloudwatch:DeleteLogGroup",
      "cloudwatch:DeleteAlarms",
      "cloudwatch:PutMetricFilter",
    ]
    resources = ["*"]
    effect    = var.effect
  }
}

data "aws_iam_policy_document" "combined_guardrails" {
  source_policy_documents = [
    data.aws_iam_policy_document.tag_enforcement.json,
    data.aws_iam_policy_document.region_restriction.json,
    data.aws_iam_policy_document.protect_critical_services.json,
  ]
}

resource "aws_iam_policy" "baseline_guardrail" {
  name        = "${var.policy_prefix}baseline"
  description = "Centralized governance guardrail policy"
  policy      = data.aws_iam_policy_document.combined_guardrails.json
}
