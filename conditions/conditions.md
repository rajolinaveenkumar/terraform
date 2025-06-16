**1. Basic Conditional Expression**
```
variable "env" {
  default = "prod"
}

resource "aws_instance" "web" {
  instance_type = var.env == "prod" ? "t3.medium" : "t2.micro"
}

```

**2. Tag Based on Condition**
```
tags = {
  Environment = var.env
  Owner       = var.env == "dev" ? "dev-team" : "ops-team"
}

```

**3. Enable/Disable Resource Based on Boolean**
```
variable "create_s3" {
  type    = bool
  default = true
}

resource "aws_s3_bucket" "my_bucket" {
  count = var.create_s3 ? 1 : 0
  bucket = "my-demo-bucket"
}

```

**4. Conditional Output**
```
output "instance_type_info" {
  value = var.env == "prod" ? "High performance" : "Basic performance"
}

```

**5. Conditional Subnet Selection**
```
variable "region" {
  default = "us-east-1"
}

locals {
  subnet_id = var.region == "us-east-1" ? "subnet-111" : "subnet-222"
}

resource "aws_instance" "web" {
  subnet_id = local.subnet_id
}

```

**6. Condition with length() or contains()**
```
variable "enabled_features" {
  type    = list(string)
  default = ["logging", "monitoring"]
}

output "logging_enabled" {
  value = contains(var.enabled_features, "logging") ? "yes" : "no"
}

```

**Real-Time Example: DNS Record Based on Server Role**
```
resource "aws_route53_record" "dns" {
  count   = length(var.names)
  zone_id = var.zone_id
  name    = "${var.names[count.index]}.${var.domain}"
  type    = "A"
  ttl     = 300
  records = [
    var.names[count.index] == "frontend"
      ? aws_instance.my_server[count.index].public_ip
      : aws_instance.my_server[count.index].private_ip
  ]
}

```

**🚀 Summary**

| Expression                | Meaning                                |
| ------------------------- | -------------------------------------- |
| `a ? b : c`               | If a is true, use b, else c            |
| `var.env == "prod"`       | Check environment                      |
| `contains(list, "value")` | Check if list contains value           |
| `length(list) > 0`        | List is not empty                      |
| `bool ? 1 : 0`            | Control resource creation with `count` |
