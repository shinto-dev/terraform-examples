variable "bucket-name" {
  type    = string
  default = "test-bucket.shintodev.com"
}

variable "enable-versioning" {
  default = true
}

variable "allow-acl-access" {
  default = false
}
