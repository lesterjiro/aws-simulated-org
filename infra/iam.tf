locals {
  # IAM Roles
  roles = [
    "root",
    "dev",
    "prod",
    "audit"
  ]

  # Who is ALLOWED to assume this role (incoming trust)
  trust_by = {
    "root"  = []
    "dev"   = ["root"]
    "prod"  = ["root", "dev"]
    "audit" = ["root"]
  }

  # Who each role CAN assume (outgoing trust)
  trust_map = {
    "dev"  = ["prod"]
    "root" = ["audit", "dev", "prod"]
  }

  tags = {
    owner       = "lester"
    project     = "aws-simulated-org"
    environment = var.env
  }

  # Permission boundary policy (guardrail)
  permissions_boundary_arn = aws_iam_policy.baseline_guardrail.arn

  # Defines IAM policies used to manage permissions across all environments.
  managed_policies = {
    "dev-basic-ops"        = ["ec2:*", "s3:*", "lambda:*"]
    "prod-limited-ops"     = ["ec2:*", "rds:*", "cloudwatch:*"]
    "audit-readonly"       = ["cloudtrail:Get*", "config:Get*", "s3:GetObject"]
    "admin-org-management" = ["iam:*", "organizations:*", "cloudtrail:*"]
  }

  # Maps each IAM policy to the role it should be attached to.
  policy_role_map = {
    "dev-basic-ops"        = "dev"
    "prod-limited-ops"     = "prod"
    "audit-readonly"       = "audit"
    "admin-org-management" = "root"
  }
}

data "aws_iam_policy_document" "managed_policies" {
  for_each = local.managed_policies
  statement {
    actions   = each.value
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "managed_policies" {
  for_each    = data.aws_iam_policy_document.managed_policies
  name        = each.key
  description = "Global managed policy: ${each.key}"
  policy      = each.value.json
}

locals {
  managed_policy_arns = {
    for name, policy in aws_iam_policy.managed_policies :
    name => policy.arn
  }
}

module "iam_cross_account" {
  source                   = "../modules/terraform-aws-iam-cross-env"
  for_each                 = local.accounts
  role_name                = each.key
  trust_by                 = local.trust_by
  trust_map                = local.trust_map
  managed_policy_arns      = local.managed_policy_arns
  policy_role_map          = local.policy_role_map
  permissions_boundary_arn = local.permissions_boundary_arn
  account_id               = each.value.account_id
  tags                     = merge(local.common_tags, { environment = each.value.env })
}
