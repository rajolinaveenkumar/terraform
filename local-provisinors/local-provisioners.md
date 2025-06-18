#  Local Provisioners

### Synatx
```
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo Instance ${self.public_ip} created!"  # Local shell command
  }
}

```
## When It Executes
* Only during terraform apply
* Runs after the resource is created

###  Real-Time Example 1: Notify via Curl
```
provisioner "local-exec" {
  command = "curl -X POST -d 'Instance created at ${self.public_ip}' https://hooks.example.com/notify"
}

* Use Case: Send a webhook notification after EC2 instance creation.
```

```
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory.txt"
  }
}
```
# 🔥 Pro Tip
### nstead of hard-coding command, you can use:
```
command = "bash scripts/configure.sh ${self.private_ip}"
```

# What is Bootstrapping?
* Bootstrapping means automatically configuring a server (or resource) right after it’s created.

exp: Think of it as the initial setup phase — like installing software, creating users, copying configs, etc.

### Real-Life Analogy:
* When you buy a new phone, the setup wizard that installs basic apps and connects Wi-Fi is bootstrapping.
exp: Same for a new EC2 server — Terraform creates it, bootstrapping scripts prepare it.

### Bootstrapping Use Cases in Terraform
| Scenario          | Action                                  |
| ----------------- | --------------------------------------- |
| EC2 Instance      | Install Nginx, Docker, configure app    |
| MySQL Server      | Run schema creation script              |
| VM                | Set hostname, install monitoring agents |
| Ansible Inventory | Write public IP to a file locally       |
| Notify Teams      | Send a webhook after server launch      |


### Provisioners Used for Bootstrapping
```
remote-exec: Run commands on the server
file: Upload config/scripts to the server
local-exec: Run things on your machine (like curl, save IP, update DNS)
```

###  Example: Bootstrapping a Web Server
```
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }
}
```


