/*
// -- TBD (ECS Wagtail) --
resource "aws_route53_record" "site-www-cname" {
  zone_id = aws_route53_zone.cyberprofessiongovuk.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = local.standard_ttl

  records = [
    "govuk-digital-backbone.github.io."
  ]
}

resource "aws_route53_record" "site-a" {
  zone_id = aws_route53_zone.cyberprofessiongovuk.zone_id
  name    = "cyber-profession.gov.uk"
  type    = "A"
  ttl     = local.standard_ttl

  # GitHub pages A records:
  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ]
}

resource "aws_route53_record" "site-aaaa" {
  zone_id = aws_route53_zone.cyberprofessiongovuk.zone_id
  name    = "cyber-profession.gov.uk"
  type    = "AAAA"
  ttl     = local.standard_ttl

  # GitHub pages AAAA records:
  records = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153"
  ]
}
*/