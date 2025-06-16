
**1. String Variable**
```
# variables.tf
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# usage in resource
resource "aws_instance" "web" {
  instance_type = var.instance_type
}

```

**2. Number Variable**
```
variable "instance_count" {
  type    = number
  default = 2
}

resource "aws_instance" "web" {
  count = var.instance_count
}


```

**3. Boolean Variable**
```
variable "enable_monitoring" {
  type    = bool
  default = true
}

resource "aws_instance" "web" {
  monitoring = var.enable_monitoring
}


```

**5. Map Variable**
```
variable "ami_map" {
  type = map(string)
  default = {
    us-east-1 = "ami-0c55b159cbfafe1f0"
    us-west-1 = "ami-0f2176987ee50226e"
  }
}

resource "aws_instance" "web" {
  ami = var.ami_map[var.region]
}


```

**6. Object Variable**
```
variable "app_config" {
  type = object({
    name = string
    port = number
  })
  default = {
    name = "myapp"
    port = 8080
  }
}

output "app_name" {
  value = var.app_config.name
}


```

**7. Passing Variables via CLI**
```
terraform apply -var="instance_type=t2.large"

```

**8. Using terraform.tfvars File**
```
# terraform.tfvars
instance_type = "t3.micro"
instance_count = 3

```

**Example Use Case: Dynamic EC2 with Tags**
```
variable "env" {
  default = "dev"
}

variable "names" {
  default = ["mysql", "backend", "frontend"]
}

resource "aws_instance" "servers" {
  count         = length(var.names)
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "${var.env}-${var.names[count.index]}"
  }
}

```


**🚀Summary Table**
| Type   | Example                         |
| ------ | ------------------------------- |
| string | `"t2.micro"`                    |
| number | `2`                             |
| bool   | `true` / `false`                |
| list   | `["a", "b"]`                    |
| map    | `{ us-east-1 = "ami-abc" }`     |
| object | `{ name = "app", port = 8080 }` |
