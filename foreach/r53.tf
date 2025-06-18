resource "aws_route53_record" "dns_records" {
    for_each = aws_instance.my_server

    zone_id = var.zone_id
    records  = each.key == "frontend" ? [each.value.public_ip] : [each.value.private_ip]
    name    = each.key == "frontend" ? var.zone_name : "${each.key}.${var.zone_name}"
    allow_overwrite = true
    type    = "A"
    ttl     = 1
}