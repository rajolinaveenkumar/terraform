# Dynamic block

###  Real-Time Example 1: AWS Security Group with Dynamic Ingress Rules

```
variable "ingress_ports" {
  default = [22, 80, 443]
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow web traffic"

  vpc_id = "vpc-12345678"

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

```

### Real-Time Example 2: Dynamic Tags
```
variable "tags_map" {
  default = {
    Project     = "TicTacToe"
    Environment = "Dev"
    Owner       = "Naveen"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t2.micro"

  dynamic "tags" {
    for_each = var.tags_map
    content {
      key   = tags.key
      value = tags.value
    }
  }
}

```

### Real-Time Example 3: IAM Policy with Dynamic Statements

```
variable "s3_actions" {
  default = ["s3:GetObject", "s3:PutObject"]
}

data "aws_iam_policy_document" "example" {
  statement {
    actions   = var.s3_actions
    resources = ["arn:aws:s3:::my-bucket/*"]
    effect    = "Allow"
  }
}

```

## When to Use dynamic:
When a nested block is optional or repeated.
When the values depend on a variable, list, or map.
Avoid overcomplicating — use regular blocks if repetition is small and fixed.

