variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "This is RHEL9 Instance Type"
}

variable "project" {
    default = "expense"
}

variable "component" {
    default = "backend"
}

variable "environment" {
    default = "dev"
}