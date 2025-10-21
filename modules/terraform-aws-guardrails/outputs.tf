output "policy_name" {
  description = "Name of the generated IAM baseline guardrail policy"
  value       = aws_iam_policy.baseline_guardrail.name
}

output "policy_arn" {
  description = "ARN of the generated IAM baseline guardrail policy"
  value       = aws_iam_policy.baseline_guardrail.arn
}

output "policy_json" {
  description = "Full combined IAM policy document in JSON"
  value       = data.aws_iam_policy_document.combined_guardrails.json
}
