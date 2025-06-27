resource "aws_instance" "importing" {
    instance_type = "t3.micro"
    ami = "ami-09c813fb71547fc4f"
    tags = {
              Name = "linux_server"
        }

}

