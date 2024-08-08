provider "aws" {
  region = "eu-west-3"
}

# Define variables
variable "bucket_name_prefix" {
  description = "The prefix for the S3 bucket name"
  type        = string
  default = "ameetbucket"
}


resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = "${var.bucket_name_prefix}-${random_id.bucket_suffix.hex}"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

# Disable public access block
resource "aws_s3_bucket_public_access_block" "website_bucket_public_access" {
  bucket = aws_s3_bucket.website_bucket.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 bucket policy to allow public read access
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website_bucket.arn}/*"
      }
    ]
  })
}

# Upload local index.html to S3 bucket
resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"
}

# Upload additional HTML file
resource "aws_s3_bucket_object" "additional_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index2.html"
  source = "./index2.html"
  content_type = "text/html"
}


# Upload CSS file
resource "aws_s3_bucket_object" "css" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "styles/main.css"
  source = "./styles/main.css"
  content_type = "text/css"
}

# Upload image file
resource "aws_s3_bucket_object" "image" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "images/logo.png"
  source = "./images/logo.png"
  content_type = "image/png"
}

# Output the website endpoint
output "website_url" {
  value = aws_s3_bucket.website_bucket.website_endpoint
}
