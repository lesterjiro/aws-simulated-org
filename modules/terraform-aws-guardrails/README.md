# terraform-aws-guardrails

This module simulates organization-level guardrails in a single AWS account setup.
It mimics the behavior of Service Control Policies (SCPs) using IAM policies, conditions, and tagging rules to restrict unwanted actions and enforce governance standards.

## Inputs

| Name              | Description                                               | Type         | Required |
| ----------------- | --------------------------------------------------------- | ------------ | -------- |
| required_tags     | List of tags that must exist on every created resource    | list(string) | yes      |
| allowed_regions   | Regions where resource creation and actions are allowed   | list(string) | yes      |
| critical_services | AWS services protected from modification or deletion      | list(string) | yes      |


## Outputs

| Name        | Description                                 |
| ----------- | ------------------------------------------- |
| policy_name | Name of the generated IAM guardrail policy  |
| policy_arn  | ARN of the generated IAM guardrail policy   |
| policy_json | Combined IAM policy document in JSON format |
