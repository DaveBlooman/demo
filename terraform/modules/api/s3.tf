resource "aws_s3_bucket" "bucket" {
  bucket = "fundapps-demo-logs"
  acl    = "private"

  lifecycle_rule {
    id      = "fundapps-demo-logs"
    prefix  = "/"
    enabled = true

    expiration {
      days = 30
    }
  }

  tags {
    Name        = "Logs"
    Environment = "Demo"
  }

}
