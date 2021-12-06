
locals {
  api_origin_id = "ELB-${var.lb_dns}"
}


resource "aws_cloudfront_distribution" "web" {

  comment = "${var.name}-cloudfront"
  enabled = true
  price_class = "PriceClass_200"
  default_root_object = "index.html"
  web_acl_id = aws_wafv2_web_acl.waf_acl.arn



  origin {
    origin_id = "${local.api_origin_id}"
    domain_name = "${var.lb_dns}"

    custom_origin_config {
      http_port = "80"
      # https_port = "443"
      origin_protocol_policy = "http-only"
      # origin_ssl_protocols = [
      #   "TLSv1.1",
      #   "TLSv1.2"]
      origin_keepalive_timeout = "60"
      origin_read_timeout = "60"
    }
  }


  default_cache_behavior {

      target_origin_id        = local.api_origin_id
      viewer_protocol_policy  = "allow-all"

      allowed_methods         = [ "HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"  ]
      cached_methods          = [ "HEAD", "GET" ]

      forwarded_values  {
        headers             = [ "*" ]
        query_string        = true
        cookies  {
          forward         = "all"
        }
      }
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    #compress               = true
  }


  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
  }

  # logging_config {
  #   bucket = "${var.log-bucket}.s3.amazonaws.com"
  #   include_cookies = false
  #   prefix = "${var.env}-${var.project}/cf-logs/"
  # }

  tags = {
    Name = "${var.name}-cloudfront"
  }

}


