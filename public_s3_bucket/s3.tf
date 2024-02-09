resource "aws_s3_bucket" "public_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "public_bucket" {
  bucket = aws_s3_bucket.public_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "public_bucket" {
  bucket = aws_s3_bucket.public_bucket.id
  policy = <<EOF
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
}