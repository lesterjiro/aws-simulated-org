terraform {
  backend "s3" {
    bucket       = "aws-simulated-org-tfstate"
    key          = "infra/dev/terraform.tfstate"
    region       = "ap-southeast-1"
    use_lockfile = true
    encrypt      = true
  }
}
