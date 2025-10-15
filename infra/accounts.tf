locals {
  account = {
    root = {
      name       = "root"
      env        = "root"
      account_id = "2025001"
      tags = merge(local.common_tags, {
        environment = "root"
      })
    }

    dev = {
      name       = "dev"
      env        = "dev"
      account_id = "2025002"
      tags = merge(local.common_tags, {
        environment = "dev"
      })
    }

    prod = {
      name       = "prod"
      env        = "prod"
      account_id = "2025003"
      tags = merge(local.common_tags, {
        environment = "prod"
      })
    }


    audit = {
      name       = "audit"
      env        = "audit"
      account_id = "2025004"
      tags = merge(local.common_tags, {
        environment = "audit"
      })
    }
  }
}
