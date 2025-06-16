variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
  description = "This is RHEL9 AMI ID"

}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "This is RHEL9 Instance Type"
}

variable "ec2_tags" {
  type = map(any)
  default = {
    Name        = "Terraform Server"
    Component   = "backend"
    Environment = "dev"
  }
}

variable "from" {
  type    = number
  default = "22"
}

variable "to" {
  type    = number
  default = "22"
}

variable "cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "sg_name" {
  type = map(any)
  default = {
    Name = "dev-SG"
  }
}