locals {
  env_accounts = {
    root  = module.accounts["root"]
    dev   = module.accounts["dev"]
    prod  = module.accounts["prod"]
    audit = module.accounts["audit"]
  }
}
