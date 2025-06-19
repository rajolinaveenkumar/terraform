***Function Categories in Terraform***
| Category        | Description              |
| --------------- | ------------------------ |
| String          | Text manipulation        |
| Numeric         | Math and number handling |
| Collection      | Lists and maps handling  |
| Encoding        | Base64, JSON, etc.       |
| Date/Time       | Time-related functions   |
| Filesystem      | Reading files            |
| Type conversion | Convert between types    |
| CIDR            | For network subnetting   |

### 1. String Functions

***join()***
```
join("-", ["dev", "test", "prod"])  → "dev-test-prod"
```
***upper() / lower()***
```
upper("devops") → "DEVOPS"
```
***replace()***
```
syntax: replace(string, substring_to_replace, new_substring)

replace("server-prod", "prod", "dev") → "server-dev"
```
### 2. Collection Functions

***👉 length()***
```
length(["a", "b", "c"]) → 3
```
***👉 contains()***
```
Syntax: contains(list, value)

contains(["mysql", "backend"], "mysql") → true
```
***👉 element()***
```
Syntax: element(list, index)

element(["a", "b", "c"], 1) → "b"
element(["dev", "staging", "prod"], 2) → "prod"
```
***👉 lookup()***
```
Syntax: lookup(map, key, default)

lookup({dev = "t2.micro", prod = "t3.medium"}, "dev", "default") → "t2.micro"
```

### 3. Numeric Functions
***👉 max() / min()***
```
max(1, 5, 3) → 5  
min(4, 2, 9) → 2
```

### 4. Date & Time Functions
***👉 timestamp()***
```
timestamp() → "2025-06-16T05:20:30Z"
```
### 5. Encoding/Decoding
***👉 base64encode() / base64decode()***
```
base64encode("my-secret") → "bXktc2VjcmV0"
```
### 6. Filesystem Functions
***👉 file()***
```
file("user_data.sh")
Reads content from a local file.
```

### 7. Type Conversion
***👉 tostring(), tolist(), tomap()***
```
tostring(123) → "123"
tomap({key = "value"}) → map
```

### Real-Time Examples

***1. Dynamic Resource Naming***
```
variable "env" {
  default = "prod"
}

resource "aws_instance" "server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = join("-", [var.env, "server", tostring(timestamp())])
  }
}
```

***2. Loop through a list using element()***
```
variable "zones" {
  default = ["us-east-1a", "us-east-1b"]
}

resource "aws_instance" "servers" {
  count             = 2
  availability_zone = element(var.zones, count.index)
}

```

***3. Read File Content for EC2 User Data***
```
resource "aws_instance" "web" {
  user_data = file("userdata.sh")
}

```

***4. Create a tag with replace() and upper()***
```
variable "env" {
  default = "dev"
}

tags = {
  Environment = upper(replace(var.env, "dev", "development"))
}
```

### Terraform slice() Function
```
slice(list, start_index, end_index)

```
* list → the list to slice
* start_index → index where slicing begins (inclusive)
* end_index → index where slicing ends (exclusive)

```
locals {
  az_list = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  selected_azs = slice(local.az_list, 0, 2)
}

output "selected_azs" {
  value = local.selected_azs
}

```
```
[
  "ap-south-1a",
  "ap-south-1b"
]

```

### Syntax of Validation Function
```
variable "region" {
  type    = string
  default = "us-east-1"

  validation {
    condition     = contains(["us-east-1", "us-west-2", "ap-south-1"], var.region)
    error_message = "Region must be one of: us-east-1, us-west-2, ap-south-1"
  }
}

```
### Summary Table

| Function      | Purpose                | Example                         |
| ------------- | ---------------------- | ------------------------------- |
| `join()`      | Combine list to string | `join("-", ["a", "b"]) → "a-b"` |
| `length()`    | Count items            | `length(list)`                  |
| `contains()`  | Check if item exists   | `contains(list, "item")`        |
| `element()`   | Get item by index      | `element(["a","b"], 1) → "b"`   |
| `file()`      | Read from file         | `file("init.sh")`               |
| `timestamp()` | Current date-time      | `timestamp()`                   |
| `lookup()`    | Get value from map     | `lookup(map, key)`              |
