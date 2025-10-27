output "account" {
  description = "Simulated AWS account metadata"
  value       = local.account
}

output "account_name" {
  description = "The name of the simulated account"
  value       = local.account.name
}

output "account_env" {
  description = "The environment label (e.g. dev, prod, root, audit)"
  value       = local.account.env
}

output "region" {
  description = "AWS region used by this account"
  value       = local.account.region
}

output "tags" {
  description = "Merged tags applied to this simulated account"
  value       = local.account.tags
}
