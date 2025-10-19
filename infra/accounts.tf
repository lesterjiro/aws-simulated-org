module "root_account" {
  source       = "../modules/terraform-aws-accounts"
  account_name = "root"
  account_env  = var.env_map["root"]
  account_id   = "2025001"
  aws_region   = var.aws_region
  project_name = var.project_name
  common_tags  = local.common_tags
}

module "dev_account" {
  source       = "../modules/terraform-aws-accounts"
  account_name = "dev"
  account_env  = var.env_map["dev"]
  account_id   = "2025002"
  aws_region   = var.aws_region
  project_name = var.project_name
  common_tags  = local.common_tags
}

module "prod_account" {
  source       = "../modules/terraform-aws-accounts"
  account_name = "prod"
  account_env  = var.env_map["prod"]
  account_id   = "2025003"
  aws_region   = var.aws_region
  project_name = var.project_name
  common_tags  = local.common_tags
}

module "audit_account" {
  source       = "../modules/terraform-aws-accounts"
  account_name = "audit"
  account_env  = var.env_map["audit"]
  account_id   = "2025004"
  aws_region   = var.aws_region
  project_name = var.project_name
  common_tags  = local.common_tags
}
