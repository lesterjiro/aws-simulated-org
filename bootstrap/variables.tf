variable "aws_region" {
  type        = string
  description = "Default AWS Region"
  default     = "ap-southeast-1"
}

variable "s3_bucket_tf_state" {
  type        = string
  description = "Bucket name for Terraform state"
  default     = "aws-simulated-org-tfstate"
}

variable "env" {
  type = map(string)
  default = {
    root = "root"
    dev  = "dev"
    prod = "prod"
  }
}
