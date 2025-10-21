module "guardrails" {
  source            = "../modules/terraform-aws-guardrails"
  required_tags     = ["Environment", "Owner", "CostCenter"]
  allowed_regions   = ["ap-southeast-1", "ap-northeast-1"]
  critical_services = ["cloudtrail.amazonaws.com", "config.amazonaws.com", "guardduty.amazonaws.com", "securityhub.amazonaws.com", "cloudwatch.amazonaws.com"]
  tags              = local.common_tags
}
