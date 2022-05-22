provider "aws" {
  region = "eu-central-1"
}

# Strings
variable "vpcname" {
  type    = string
  default = "myvpc"
}

# Numbers
variable "sshport" {
  type    = number
  default = 24
}

# Booleans : doesn't require a type.
variable "enabled" {
  default = true
}

# Lists
# index starts with 0.
variable "mylist" {
  type    = list(string)
  default = ["value1", "value2"]
}

# Map
variable "mymap" {
  type    = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}

# Input
variable "inputname" {
  type        = string
  description = "Set the name of the vpc"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags       = {
    Name : var.inputname
  }
}

output "vpcid" {
  value = aws_vpc.myvpc.id
}


variable "mytuple" {
  type    = tuple([number, string, number])
  default = [1, "hello", 2]
}

variable "myobject" {
  type = object({
    name = string
    ports = list(number)
  })
  default = {
    name = "TJ"
    ports = [80, 442]
  }
}
