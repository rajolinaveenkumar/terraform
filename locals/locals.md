### Real-Time Example 2: Combine Subnet CIDRs
```
locals {
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  all_subnets = concat(local.public_subnets, local.private_subnets)
}

```

### Real-Time Example 3: Use in Conditions

```
variable "env" {
  default = "prod"
}

locals {
  instance_type = var.env == "prod" ? "t3.medium" : "t2.micro"
}

resource "aws_instance" "web" {
  ami           = "ami-0abcdef1234567890"
  instance_type = local.instance_type
}

```