provider "aws" {
  region = "eu-central-1"
}

variable "bucket-name" {
  type    = string
  default = "test-bucket.shintodev.com"
}

variable "enable-versioning" {
  default = true
}

variable "allow-public-access" {
  default = false
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket-name

  tags = {
    Name = "My bucket"
  }
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id

  acl = var.allow-public-access? "public" : "private"
}

resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = var.enable-versioning? "Enabled" : "Disabled"
  }
}
