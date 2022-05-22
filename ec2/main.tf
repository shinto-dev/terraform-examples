provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_instance" {
  ami             = "ami-04c921614424b07cd"
  # you can find the ami from the AWS console -> Choose an Amazon Machine Image (AMI) page
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web_traffic.name]
}

# Now let's create an elastic IP (eip)
resource "aws_eip" "elastic_eip" {
  instance = aws_instance.my_instance.id
}


output "eip" {
  value = aws_eip.elastic_eip.public_ip
}

variable "ingress_rules" {
  type    = list(number)
  default = [80, 443]
}

variable "egress_rules" {
  type    = list(number)
  default = [80, 443, 25, 3306, 53]
}

resource "aws_security_group" "web_traffic" {
  name = "Allow HTTPS"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_rules

    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress_rules

    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}


# Reference Docs:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
