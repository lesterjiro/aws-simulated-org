variable "role_name" {
  description = "IAM role to create for this account."
  type        = string
}

variable "trust_by" {
  description = "Defines which roles are allowed to assume each role (incoming trust relationships)."
  type        = map(list(string))
}

variable "trust_map" {
  description = "Defines which roles can be assumed by each role (outgoing trust relationships)."
  type        = map(list(string))
}

variable "managed_policy_arns" {
  description = "Map of IAM policy names to their ARNs to attach to this role. Policies are created globally outside this module."
  type        = map(string)
}

variable "policy_role_map" {
  description = "Maps each IAM policy to the role it should attach to."
  type        = map(string)
}

variable "permissions_boundary_arn" {
  description = "ARN of the IAM permissions boundary policy applied to all roles."
  type        = string
}
variable "account_id" {
  description = "Simulated AWS account ID used to represent each environment for trust and policy mapping."
  type        = string
}

variable "tags" {
  description = "Common tags applied to all IAM resources for cost tracking and ownership identification."
  type        = map(string)
}
