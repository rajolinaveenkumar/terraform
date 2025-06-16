resource "aws_route53_record" "for_private_dns" {
    count = 3         # count = length(var.instances)
    zone_id = var.zone_id
    name = "${aws_instance.my_server[count.index].tags.Name}.${var.zone_name}" # its a interpolation
    type = "A"
    ttl = 1
    records = [aws_instance.my_server[count.index].private_ip]
    # records = [aws_instance.my_server[count.index].tags.Name == "frontend" ? "${aws_instance.my_server[2].public_ip}" : "${aws_instance.my_server[count.index].private_ip}"]
    allow_overwrite = true
}

resource "aws_route53_record" "for_public_dns" {
    
    zone_id = var.zone_id
    name = var.zone_name
    type = "A"
    ttl = 1
    records = [aws_instance.my_server[2].public_ip]
    allow_overwrite = true
}