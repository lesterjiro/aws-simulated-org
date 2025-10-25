resource "aws_iam_role" "env_role" {
  name                 = var.role_name
  assume_role_policy   = data.aws_iam_policy_document.role_trust.json
  permissions_boundary = var.permissions_boundary_arn
  tags                 = merge(var.tags, { role = var.role_name })
}


data "aws_iam_policy_document" "role_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    dynamic "principals" {
      for_each = try(length(var.trust_by[var.role_name]) > 0 ? [1] : [], [])
      content {
        type = "AWS"
        identifiers = [
          for r in lookup(var.trust_by, var.role_name, []) :
          "arn:aws:iam::${var.account_id}:role/${r}"
        ]
      }
    }
  }
}

data "aws_iam_policy_document" "cross_env_access" {
  count = contains(keys(var.trust_map), var.role_name) ? 1 : 0

  statement {
    sid     = "allow-assume-roles-${var.role_name}"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    resources = [
      for target_role in lookup(var.trust_map, var.role_name, []) :
      "arn:aws:iam::${var.account_id}:role/${target_role}"
    ]
  }
}

resource "aws_iam_role_policy" "cross_env_access" {
  count  = contains(keys(var.trust_map), var.role_name) ? 1 : 0
  name   = "${var.role_name}-assumes-roles-policy"
  role   = aws_iam_role.env_role.name
  policy = data.aws_iam_policy_document.cross_env_access[0].json
}

resource "aws_iam_role_policy_attachment" "managed_policies" {
  for_each   = { for k, v in var.policy_role_map : k => v if v == var.role_name }
  role       = aws_iam_role.env_role.name
  policy_arn = var.managed_policy_arns[each.key]
}
