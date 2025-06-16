data "aws_ami" "rhel9" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami_id" {
    value = data.aws_ami.rhel9.id
}

data "aws_vpc" "defaultvpc" {
  default = true
}

output "vpcid"{
    value = data.aws_vpc.defaultvpc.id
}