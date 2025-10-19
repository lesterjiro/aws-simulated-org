# terraform-aws-accounts

This module simulates an AWS account within a multi-account organization setup.
It defines account-specific settings, environment metadata, and standardized tagging.

## Inputs

| Name         | Description                                                       | Type        | Required |
| ------------ | ----------------------------------------------------------------- | ----------- | -------- |
| account_name | Human-readable name of the account (e.g., dev, prod, root, audit) | string      | yes      |
| account_env  | Environment label for this account (e.g., dev, prod, root)        | string      | yes      |
| account_id   | Unique simulated account ID (used for tagging or reference)       | string      | yes      |
| aws_region   | AWS region for resources                                          | string      | yes      |
| project_name | Project name for consistent tagging and naming                    | string      | yes      |
| common_tags  | Base tags merged with environment-specific tags                   | map(string) | yes      |

## Outputs

| Name    | Description                                                               |
| ------- | ------------------------------------------------------------------------- |
| account | Object containing account metadata: `id`, `name`, `env`, `region`, `tags` |
