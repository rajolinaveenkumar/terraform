resource "aws_instance" "my_server" {
  for_each = var.instance_type
  ami                    = "ami-09c813fb71547fc4f"
  instance_type          = each.value
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  # Log IPs to local file
  provisioner "local-exec" {
    command = "echo '${each.key} = ${self.private_ip}' >> local-exec-inventory.txt"
  }

  # SSH connection block
  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = self.public_ip
  }

  # Copy playbook to EC2
  provisioner "file" {
    source = "ansible_roles_expense_project"
    destination = "/home/ec2-user/"
  }

  # Run Ansible on EC2
  provisioner "remote-exec" {
    inline  = [
      "sudo dnf install ansible -y",
      # "ls -l /home/ec2-user",
      # "ansible-playbook -i inventory.ini /home/ec2-user/ansible_roles_expense_project/${each.key}.yaml"
    ]
  }
  tags = {
    Name = each.key
  }

}




resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "Terraform-Security-Group"
  }
}
