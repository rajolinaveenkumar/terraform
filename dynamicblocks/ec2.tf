resource "aws_instance" "my_server" {
  
  ami                    = "ami-09c813fb71547fc4f"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "linux_server"
  }

}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port = ingress.value["from_port"]
      to_port = ingress.value["to_port"]
      protocol      = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
    
  }

  dynamic "egress"{
    for_each = var.egress_ports
    content {
      from_port = egress.value["from_port"]
      to_port = egress.value["to_port"]
      protocol     = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }

  tags = {
    Name = "Terraform-Security-Group"
  }
}
