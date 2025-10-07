resource "aws_s3_bucket" "bootstrap_state_bucket" {
  bucket = "${var.s3_bucket_tf_state}"

  tags = {
    Name        = "${var.s3_bucket_tf_state}"
    Environment = "${var.env["root"]}"
  }
}

resource "aws_s3_bucket_versioning" "bootstrap_state_bucket_versioning" {
  bucket = aws_s3_bucket.bootstrap_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "tfstate_key" {
  description             = "Key to encrypt bucket objects"
  deletion_window_in_days = 10

  tags = {
    Name        = "aws-simulated-org-kms-key"
    Environment = "${var.env["root"]}"
  }
}

resource "aws_s3_bucket_public_access_block" "bootstrap_state_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.bootstrap_state_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bootstrap_state_bucket_encryption" {
  bucket = aws_s3_bucket.bootstrap_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tfstate_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
