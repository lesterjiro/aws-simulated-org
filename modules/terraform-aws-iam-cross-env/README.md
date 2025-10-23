# terraform-aws-iam-cross-env

This module creates IAM roles for simulated environments within a single AWS account.
It defines role trust relationships, cross-environment assume-role policies, and attaches managed policies with optional permissions boundaries.

## Inputs

| Name                     | Description                                                                                  | Type           | Required |
| ------------------------ | -------------------------------------------------------------------------------------------- | -------------- | -------- |
| role_name                | Name of the IAM role to create                                                               | string         | yes      |
| trust_by                 | Map defining which roles are allowed to assume this role (incoming trust relationships)      | map(list(string)) | yes   |
| trust_map                | Map defining which roles this role can assume (outgoing trust relationships)                 | map(list(string)) | yes   |
| managed_policies         | Map of IAM policy names to allowed actions                                                  | map(list(string)) | yes   |
| policy_role_map          | Map linking each managed policy to the IAM role it should attach to                          | map(string)    | yes      |
| permissions_boundary_arn | ARN of the IAM permissions boundary policy applied to all roles                              | string         | no       |
| account_id               | Simulated AWS account ID used for trust and policy references                                | string         | yes      |
| tags                     | Map of tags applied to all IAM resources for identification and cost tracking               | map(string)    | no       |
| managed_policy_arns      | Map of policy names to ARNs (if using pre-existing policies instead of creating new ones)    | map(string)    | no       |

## Outputs

| Name                     | Description                                                                                     |
| ------------------------ | ----------------------------------------------------------------------------------------------- |
| role_name                | Identifier of the IAM role created by this module                                               |
| role_arn                 | ARN of the IAM role, usable in trust policies or cross-account role assumption                  |
| managed_policy_resources | List of ARNs for the managed policies attached to this role                                     |
| cross_env_policy_name    | Name of the inline policy enabling cross-environment assume-role permissions                    |
| cross_env_policy_arn     | ARN of the inline policy allowing this role to assume other roles across environments           |
| role_tags                | Tags assigned to the IAM role for ownership, environment, and project identification            |
