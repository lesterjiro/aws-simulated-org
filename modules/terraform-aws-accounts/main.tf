locals {
  tags = merge(
    var.common_tags,
    {
      project      = var.project_name,
      account_name = var.account_name,
      environment  = var.account_env,
      region       = var.aws_region
    }
  )

  account = {
    name   = var.account_name
    env    = var.account_env
    region = var.aws_region
    tags   = local.tags
  }
}

# Placeholder to simulate an AWS account resource
# (In a real org you'd use aws_organizations_account, but it's a just a simulation this time)
resource "null_resource" "account" {
  triggers = {
    name   = local.account.name
    env    = local.account.env
    region = local.account.region
    tags   = jsonencode(local.tags)
  }
}
