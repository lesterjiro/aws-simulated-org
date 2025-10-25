# terraform-aws-iam-cross-env

This module creates IAM roles for simulated environments within a single AWS account.
It defines role trust relationships, cross-environment assume-role policies, and attaches managed policies with optional permissions boundaries.

## Inputs

| Name                     | Description                                                                                  | Type               | Required |
| ------------------------ | -------------------------------------------------------------------------------------------- | ------------------ | -------- |
| role_name                | Name of the IAM role to create                                                               | string             | yes      |
| trust_by                 | Map defining which roles are allowed to assume this role (incoming trust relationships)      | map(list(string))  | yes      |
| trust_map                | Map defining which roles this role can assume (outgoing trust relationships)                 | map(list(string))  | yes      |
| managed_policy_arns      | Map of IAM policy names to their ARNs for attachment                                         | map(string)        | yes      |
| policy_role_map          | Map linking each managed policy to the IAM role it should attach to                          | map(string)        | yes      |
| permissions_boundary_arn | ARN of the IAM permissions boundary policy applied to all roles                              | string             | no       |
| account_id               | Simulated AWS account ID used for trust and policy references                                | string             | yes      |
| tags                     | Map of common tags applied to IAM resources for ownership and cost tracking                  | map(string)        | no       |

## Outputs

| Name                     | Description                                                                                     |
| ------------------------ | ----------------------------------------------------------------------------------------------- |
| role_name                | Identifier of the IAM role created by this module                                               |
| role_arn                 | ARN of the IAM role, usable in trust policies or cross-account role assumption                  |
| managed_policy_resources | List of managed policy attachments created for this role                                        |
| cross_env_policy_name    | Name of the inline policy granting this role cross-environment assume-role permissions           |
| role_tags                | Tags assigned to the IAM role for ownership, environment, and project identification            |
