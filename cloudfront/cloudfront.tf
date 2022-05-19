provider "aws" {
  region = "us-east-1"
}


# S3
resource "aws_s3_bucket" "bucketjuyuju" {
bucket = "s3-terraform-bucket-lab-new-me"
acl    = "public-read"   # or can be "public-read"

tags = {
Name        = "My bucket"
Environment = "Dev"
}

}


# CloudFront

resource "aws_cloudfront_distribution" "cloudfront" {

  enabled             = true
  default_root_object = "index.html"
#   aliases             = [ "cloudfront.cloudgeeks.ca","doosra.saqlainmushtaq.com" ] # (Required) For HTTPS Requirement, must be DNS Validated & dns name must Only associated be associated with single distribution in single aws account.

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"] # "DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.bucketjuyuju.id
    viewer_protocol_policy = "redirect-to-https" # redirect-to-https # https-only # allow-all
  

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
      
      
      
    forwarded_values {
      query_string = true

      headers = [
        "Origin"
      ]

      cookies {
        forward = "none"
      }
    }
  }

  origin {
    domain_name = aws_s3_bucket.bucketjuyuju.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.bucketjuyuju.id

    custom_header {
      name  = "*.invaluable.com"
      value = "*"
    }

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.cloudfront_access_identity_path
    }

  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    # acm_certificate_arn            = "arn:aws:acm:us-east-1:YOURACCOUNTID:certificate/12345678CBA123456789" # ACM Cert Arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }
}


# Cloudfront Origin Access Identity
resource "aws_cloudfront_origin_access_identity" "cloudfront_origin_access_identity" {
  comment    = "Only This User is allowed for S3 Read bucket"
}
