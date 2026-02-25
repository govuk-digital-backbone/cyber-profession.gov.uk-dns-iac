resource "aws_route53_zone" "cyberprofessiongovuk" {
  name = local.domain

  tags = merge(local.default_tags, {
    "Name" : local.domain,
    "Environment" : "prod"
  })

  lifecycle {
    ignore_changes = [tags]
  }
}

/*
// -- TBD
resource "aws_route53_record" "gh-verification" {
  zone_id = aws_route53_zone.cyberprofessiongovuk.zone_id
  name    = "_gh-govuk-digital-backbone-o"
  type    = "TXT"
  ttl     = local.standard_ttl

  records = [
    "801a7ec0ae",
  ]
}
*/

resource "aws_route53_record" "security_txt-prod" {
  zone_id = aws_route53_zone.cyberprofessiongovuk.zone_id
  name    = "_security"
  type    = "TXT"
  ttl     = local.standard_ttl

  records = [
    "security_policy=https://vulnerability-reporting.service.security.gov.uk/.well-known/security.txt",
    "security_contact=https://vulnerability-reporting.service.security.gov.uk/submit",
  ]
}

module "aws-r53-parked-domain" {
  source            = "github.com/co-cddo/aws-route53-parked-govuk-domain//terraform?ref=5e85556ce417cd335c440fd1e7079bd331f443d5"
  zone_id           = aws_route53_zone.cyberprofessiongovuk.zone_id
  depends_on        = [aws_route53_zone.cyberprofessiongovuk]
  email_records     = true  # default
  webserver_records = false # default
  additional_txt_records = [
    "security_policy=https://vulnerability-reporting.service.security.gov.uk/.well-known/security.txt"
  ]
}
