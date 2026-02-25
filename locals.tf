locals {
  domain = "cyber-profession.gov.uk"

  default_tags = {
    "Service" : "cyber-profession.gov.uk",
    "Reference" : "https://github.com/govuk-digital-backbone/cyber-profession.gov.uk-dns-iac",
  }

  extra_low_ttl = 30
  low_ttl       = 300
  standard_ttl  = 3600
  long_ttl      = 86400
}
