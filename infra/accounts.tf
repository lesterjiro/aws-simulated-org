locals {
  accounts = {
    root = {
      name = "root"
      env  = "root"
    }

    dev = {
      name = "dev"
      env  = "development"
    }

    prod = {
      name = "prod"
      env  = "production"
    }

    audit = {
      name = "audit"
      env  = "audit"
    }
  }
}

module "accounts" {
  source       = "../modules/terraform-aws-accounts"
  for_each     = local.accounts
  account_name = each.value.name
  account_env  = each.value.env
  aws_region   = var.aws_region
  project_name = var.project_name
  common_tags = merge(local.common_tags, {
    environment = each.value.env
  })
}
