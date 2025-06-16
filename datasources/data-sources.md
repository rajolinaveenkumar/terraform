# What is a Data Source in Terraform?
1. Data source is used to query the existing information from the provider.
2. its help us to fetch the existing infromation from aws dynamically.

## Why use it?
* To read values from already existing infrastructure.
* To query information (like latest AMIs, VPCs, subnets, secrets).
* To avoid hardcoding values.

### Example: Get Latest Amazon Linux AMI
```
data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  owners = ["137112412989"] # Amazon
}

resource "aws_instance" "my_instance" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
}
```


### Terraform Data Sources with Internal Keys and Real-Time Use Cases

| **Data Source**                     | **Key Names Used Inside Data Source Block**                 | **Real-Time Use Case**                                     |
| ----------------------------------- | ----------------------------------------------------------- | ---------------------------------------------------------- |
| `aws_ami`                           | `most_recent`, `owners`, `filter`, `name`, `values`         | Get latest Amazon Linux or Ubuntu AMI                      |
| `aws_ami_ids`                       | `owners`, `name_regex`, `sort_ascending`                    | Get all Ubuntu AMI IDs for automation or filtering         |
| `aws_availability_zones`            | `state`, `all_availability_zones`                           | Distribute EC2s across AZs                                 |
| `aws_caller_identity`               | *(No keys needed – static)*                                 | Tag infra with account ID                                  |
| `aws_iam_policy_document`           | `statement`, `actions`, `resources`, `effect`, `principals` | Create dynamic IAM policies                                |
| `aws_instance`                      | `instance_id`, `tags`, `filter`, `availability_zone`        | Attach new EBS volume to an existing instance              |
| `aws_key_pair`                      | `key_name`, `filter`, `tags`                                | Attach key to EC2 instances                                |
| `aws_route53_zone`                  | `name`, `private_zone`, `vpc_id`, `zone_id`                 | Create DNS records in existing domain                      |
| `aws_s3_bucket`                     | `bucket`, `tags`, `filter`                                  | Read bucket region or ARN                                  |
| `aws_secretsmanager_secret`         | `name`, `tags`, `filter`                                    | Read database credentials securely                         |
| `aws_secretsmanager_secret_version` | `secret_id`, `version_id`, `version_stage`                  | Use latest version of secret in deployments                |
| `aws_security_group`                | `name`, `tags`, `filter`, `vpc_id`                          | Reuse SG instead of creating a new one                     |
| `aws_ssm_parameter`                 | `name`, `with_decryption`                                   | Fetch DB password, config, etc.                            |
| `aws_subnet`                        | `id`, `filter`, `tags`                                      | Attach resources to existing subnets                       |
| `aws_subnets`                       | `filter`, `tags`, `vpc_id`                                  | Loop through subnets for ECS or RDS                        |
| `aws_vpc`                           | `default`, `tags`, `filter`, `cidr_block`                   | Attach EC2 or ALB into existing VPC                        |
| `terraform_remote_state`            | `backend`, `config`                                         | Use shared VPC or DB outputs from another workspace/module |
| `http`                              | `url`, `request_headers`, `request_body`, `method`          | Read remote JSON or IPs from API                           |
| `template_file` *(deprecated)*      | `template`, `vars`                                          | Generate config/user\_data (use `templatefile()` now)      |

