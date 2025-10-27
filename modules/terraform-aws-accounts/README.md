# terraform-aws-accounts

This module defines a simulated AWS account as part of a multi-account setup.
It provides account-level settings, environment metadata, and consistent tagging conventions.

## Inputs

| Name         | Description                                               | Type        | Required |
| ------------ | --------------------------------------------------------- | ----------- | -------- |
| account_name | Name of the account (e.g. dev, prod, root, audit)         | string      | yes      |
| account_env  | Environment label for this account (e.g. dev, prod, root) | string      | yes      |
| aws_region   | AWS region for resources                                  | string      | yes      |
| project_name | Project name for consistent naming and tagging            | string      | yes      |
| common_tags  | Base tags merged with environment-specific tags           | map(string) | yes      |

## Outputs

| Name           | Description                                                |
| -------------- | ---------------------------------------------------------- |
| account        | Account metadata including id, name, env, region, and tags |
| account_name   | The name of the simulated account                          |
| account_env    | The environment label (e.g. dev, prod, root, audit)        |
| region         | AWS region used by this account                            |
| tags           | Merged tags applied to this simulated account              |
