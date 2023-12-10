resource "aws_route53_zone" "hanghae_dns" {
  name          = var.route53.domain
}

resource "aws_route53_record" "hanghae_dns_www" {
  zone_id = aws_route53_zone.hanghae_dns.zone_id
  name    = var.route53.name
  type    = "CNAME"
  ttl     = "300"
  records = [var.route53.url]
}