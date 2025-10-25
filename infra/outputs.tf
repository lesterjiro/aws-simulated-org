output "accounts" {
  description = "Metadata for all simulated AWS accounts."
  value = {
    for k, mod in module.accounts : k => {
      name       = mod.account_name
      env        = mod.account_env
      account_id = mod.account_id
      region     = var.aws_region
      tags       = mod.tags
    }
  }
}

output "guardrails_policy_arn" {
  description = "ARN of the baseline guardrail IAM policy."
  value       = module.guardrails.policy_arn
}

output "guardrails_policy_name" {
  description = "Name of the baseline guardrail IAM policy."
  value       = module.guardrails.policy_name
}

output "iam_roles" {
  description = "IAM roles created across simulated environments."
  value = {
    for k, mod in module.iam_cross_account : k => {
      role_name                = mod.role_name
      role_arn                 = mod.role_arn
      cross_env_policy_name    = mod.cross_env_policy_name
      cross_env_role_arn       = mod.cross_env_role_arn
      managed_policy_resources = mod.managed_policy_resources
      tags                     = mod.role_tags
    }
  }
}

output "project_name" {
  description = "The name of the overall project."
  value       = var.project_name
}

output "aws_region" {
  description = "AWS region used for infrastructure deployment."
  value       = var.aws_region
}
