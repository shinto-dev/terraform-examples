provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "db_server" {
  ami = "ami-04c921614424b07cd"
  instance_type = "t2.micro"
  tags = {
    Name = "DB Server"
  }
}

resource "aws_instance" "web_server" {
  ami = "ami-04c921614424b07cd"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web_server_sg.name]
  user_data = file("server-script.sh")
  tags = {
    Name = "Web Server"
  }
}

resource "aws_eip" "web_server_eip" {
  instance = aws_instance.web_server.id
}

variable "ingress_rules" {
  type = list(number)
  default = [80, 443]
}

variable "egress_rules" {
  type = list(number)
  default = [80, 443]
}


resource "aws_security_group" "web_server_sg" {
  name = "Web server security group"
  dynamic ingress {
    for_each = var.ingress_rules
    iterator = port

    content {
      from_port = port.value
      to_port   = port.value
      protocol  = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic egress {
    for_each = var.egress_rules
    iterator = port

    content {
      from_port = port.value
      to_port   = port.value
      protocol  = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

output "db_server_private_ip" {
  value = aws_instance.db_server.private_ip
}

output "webserver_public_ip" {
  value = aws_eip.web_server_eip.public_ip
}
