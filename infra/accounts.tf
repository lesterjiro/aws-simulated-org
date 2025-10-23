locals {
  accounts = {
    root = {
      name       = "root"
      env        = "root"
      account_id = "2025001"
    }

    dev = {
      name       = "dev"
      env        = "development"
      account_id = "2025002"
    }

    prod = {
      name       = "prod"
      env        = "production"
      account_id = "2025003"
    }

    audit = {
      name       = "audit"
      env        = "audit"
      account_id = "2025004"
    }
  }
}

module "accounts" {
  source   = "../modules/terraform-aws-accounts"
  for_each = local.accounts

  account_name = each.value.name
  account_env  = each.value.env
  account_id   = each.value.account_id
  aws_region   = var.aws_region
  project_name = var.project_name
  common_tags = merge(local.common_tags, {
    environment = each.value.env
  })
}
