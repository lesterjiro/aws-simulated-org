locals {
  # IAM Roles
  roles = [
    "root-admin",
    "dev-role",
    "prod-role",
    "audit-role"
  ]

  # Who is ALLOWED to assume this role (incoming trust)
  trust_by = {
    "root-admin" = []
    "dev-role"   = ["root-admin"]
    "prod-role"  = ["root-admin", "dev-role"]
    "audit-role" = ["root-admin"]
  }

  # Who each role CAN assume (outgoing trust)
  trust_map = {
    "dev-role"   = ["prod-role"]
    "root-admin" = ["audit-role", "dev-role", "prod-role"]
  }

  tags = {
    owner       = "lester"
    project     = "aws-simulated-org"
    environment = var.env
  }

  # Permission boundary policy (guardrail)
  permissions_boundary = aws_iam_policy.baseline_guardrail.arn


  # Defines IAM policies used to manage permissions across all environments.
  managed_policies = {
    "dev-basic-ops"        = ["ec2:*", "s3:*", "lambda:*"]
    "prod-limited-ops"     = ["ec2:*", "rds:*", "cloudwatch:*"]
    "audit-readonly"       = ["cloudtrail:Get*", "config:Get*", "s3:GetObject"]
    "admin-org-management" = ["iam:*", "organizations:*", "cloudtrail:*"]
  }

  # Maps each IAM policy to the role it should be attached to.
  policy_role_map = {
    "dev-basic-ops"        = "dev-role"
    "prod-limited-ops"     = "prod-role"
    "audit-readonly"       = "audit-role"
    "admin-org-management" = "root-admin"
  }
}

resource "aws_iam_role" "env_roles" {
  for_each = { for r in local.roles: r => r}

  name                 = each.value
  assume_role_policy   = data.aws_iam_policy_document.role_trust[each.value].json
  permissions_boundary = local.permissions_boundary
  tags                 = merge(local.tags, { role = each.value })
}

data "aws_iam_policy_document" "role_trust" {
  for_each = { for r in local.roles: r => r }

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    dynamic "principals" {
      for_each = try(length(local.trust_by[each.value]) > 0 ? [1] : [], [])
      content {
        type = "AWS"
        identifiers = [
          for r in lookup(local.trust_by, each.value, []) :
          "arn:aws:iam::${local.account[replace(r, "-role", "")].account_id}:role/${r}"
        ]
      }
    }
  }
}

data "aws_iam_policy_document" "cross_env_access" {
  for_each = local.trust_map

  statement {
    sid     = "allow-assume-roles-${each.key}"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    resources = [
      for target_role in each.value :
      "arn:aws:iam::${local.account[replace(target_role, "-role", "")].account_id}:role/${target_role}"
    ]
  }
}

resource "aws_iam_role_policy" "cross_env_access" {
  for_each = local.trust_map

  name   = "${each.key}-assumes-roles-policy"
  role   = aws_iam_role.env_roles[each.key].name
  policy = data.aws_iam_policy_document.cross_env_access[each.key].json
}

data "aws_iam_policy_document" "managed_policies" {
  for_each = local.managed_policies

  statement {
    sid       = "managed-policies-for-${each.key}"
    actions   = each.value
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "managed_policies" {
  for_each = local.managed_policies

  name        = each.key
  description = "IAM policies for consistent access management"
  policy      = data.aws_iam_policy_document.managed_policies[each.key].json
}

resource "aws_iam_role_policy_attachment" "managed_policies" {
  for_each = local.policy_role_map

  role       = aws_iam_role.env_roles[each.value].name
  policy_arn = aws_iam_policy.managed_policies[each.key].arn
}
