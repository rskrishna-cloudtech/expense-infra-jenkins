# Data source to get the cloudfront cache policy id.
data "aws_cloudfront_cache_policy" "cache_enable" {
  name = "Managed-CachingOptimized"
}

# Data source to get the cloudfront cache policy disabled id.
data "aws_cloudfront_cache_policy" "cache_disable" {
  name = "Managed-CachingDisabled"
}

# Data source to get the ACM Certificate arn from SSM parameter store.
data "aws_ssm_parameter" "acm_certificate_arn" {
  name = "/${var.project_name}/${var.environment}/acm_certificate_arn"
}
