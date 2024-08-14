output "bucket_name" {
  value = aws_s3_bucket.example.id
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.example.id
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.example.domain_name
}
