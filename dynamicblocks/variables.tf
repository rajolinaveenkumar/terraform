variable "ingress_ports" {
    default =[
        {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port = 8080
            to_port = 8080
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
}

variable "egress_ports" {
    default = [
    {
    from_port   = "22"
    to_port     = "22"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    },
     {
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    },
     {
    from_port   = "443"
    to_port     = "443"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

 ]
}