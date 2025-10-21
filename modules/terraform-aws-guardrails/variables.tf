variable "required_tags" {
  description = "List of mandatory tags to enforce on resource creation"
  type        = list(string)
}

variable "allowed_regions" {
  description = "Regions allowed for resource operations"
  type        = list(string)
}

variable "critical_services" {
  description = "List of critical AWS services that should be protected"
  type        = list(string)
}

variable "policy_prefix" {
  description = "Prefix for all IAM guardrail policies"
  type        = string
  default     = "guardrail-"
}

variable "effect" {
  description = "Effect of the IAM policy statements"
  type        = string
  default     = "Deny"
}

variable "tags" {
  description = "Common tags to apply to the IAM policy"
  type        = map(string)
  default     = {}
}
