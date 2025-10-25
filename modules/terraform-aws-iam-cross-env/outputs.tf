output "role_name" {
  description = "Identifier of the IAM role created by this module."
  value       = aws_iam_role.env_role.name
}

output "role_arn" {
  description = "ARN of the IAM role, usable in trust policies or cross-account role assumption."
  value       = aws_iam_role.env_role.arn
}

output "managed_policy_resources" {
  description = "List of ARNs of managed policies attached to this role."
  value       = [for key, role in var.policy_role_map : var.managed_policy_arns[key] if role == var.role_name]
}

output "cross_env_policy_name" {
  description = "Name of the inline cross-environment assume-role policy."
  value       = aws_iam_role_policy.cross_env_access[*].name
}

output "cross_env_role_arn" {
  description = "ARN of the IAM role associated with the inline cross-environment policy."
  value       = aws_iam_role.env_role.arn
}

output "role_tags" {
  description = "Tags assigned to this role, indicating ownership, environment, and project."
  value       = aws_iam_role.env_role.tags
}
