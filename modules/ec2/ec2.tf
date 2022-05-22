variable "ec2name" {
  type = string
}

resource "aws_instance" "my_instance" {
  ami           = "ami-04c921614424b07cd"
  instance_type = "t2.micro"
  tags          = {
    Name = var.ec2name
  }
}

output "instance_id" {
  value = aws_instance.my_instance.id
}
