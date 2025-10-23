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
  value       = [for key, _ in aws_iam_role_policy_attachment.managed_policies : aws_iam_policy.managed_policies[key].arn]
}

output "cross_env_policy_name" {
  description = "Name of the inline policy granting this role cross-environment assume-role permissions."
  value       = aws_iam_role_policy.cross_env_access[*].name
}

output "cross_env_policy_arn" {
  description = "ARN of the inline policy enabling cross-environment role assumption."
  value       = aws_iam_role_policy.cross_env_access[*].arn
}

output "role_tags" {
  description = "Tags assigned to this role, indicating ownership, environment, and project."
  value       = aws_iam_role.env_role.tags
}
