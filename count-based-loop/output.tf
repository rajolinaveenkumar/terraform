output "ec2_info" {
    value = aws_instance.my_server
}

output "ec2_info_private_ip" {
    value = aws_instance.my_server[0].private_ip
}

output "ec2_info_server_name" {
    value = aws_instance.my_server[1].tags.Name
}

# Note:
# 1.❌ The "count" object can only be used inside resource, module, or data blocks — not in output blocks.
# insted of count.index we use below example

output "ec2_info_public_ips" {
  value = aws_instance.my_server[*].public_ip
}

output "ec2_info_server_names" {
    value = aws_instance.my_server[*].tags.Name
}

