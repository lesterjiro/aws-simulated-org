terrform {
  backend "s3" {
    bucket       = "aws-simulated-org-tfstate"
    key          = "infra/root/terraform.tfstate"
    region       = "ap-southeast-1"
    use_lockfile = true
    encrypt      = true
  }
}
