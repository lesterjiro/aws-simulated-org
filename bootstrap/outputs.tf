output "s3_bucket" {
  value       = aws_s3_bucket.bootstrap_state_bucket.arn
  description = "Remote state S3 bucket"
}
