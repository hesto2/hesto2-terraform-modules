resource "aws_s3_bucket" "public_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "public_bucket" {
  bucket     = aws_s3_bucket.public_bucket.id
  acl        = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.public_bucket]
}

resource "aws_s3_bucket_public_access_block" "public_bucket" {
  bucket = aws_s3_bucket.public_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "public_bucket" {
  bucket = aws_s3_bucket.public_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.public_bucket]
}

resource "aws_s3_bucket_policy" "public_bucket" {
  bucket     = aws_s3_bucket.public_bucket.id
  policy     = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.public_bucket.arn}/*"
        }
    ]
}
EOF
  depends_on = [aws_s3_bucket_public_access_block.public_bucket]
}
