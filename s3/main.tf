provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket-name
  lifecycle {
    ignore_changes = [
      grant,
      server_side_encryption_configuration
    ]
  }

  tags = {
    Name = "My bucket"
  }
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id

  acl = var.allow-acl-access? "public" : "private"
}

resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = var.enable-versioning? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "my-bucket-sse" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
