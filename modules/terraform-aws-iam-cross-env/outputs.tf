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
  value = [
    for policy_name, attached_role in var.policy_role_map :
    var.managed_policy_arns[policy_name]
    if attached_role == var.role_name && contains(keys(var.managed_policy_arns), policy_name)
  ]
}

output "cross_env_policy_name" {
  description = "Name of the inline cross-environment assume-role policy."
  value       = length(aws_iam_role_policy.cross_env_access) > 0 ? aws_iam_role_policy.cross_env_access[0].name : null
}

output "role_tags" {
  description = "Tags assigned to this role, indicating ownership, environment, and project."
  value       = aws_iam_role.env_role.tags
}
