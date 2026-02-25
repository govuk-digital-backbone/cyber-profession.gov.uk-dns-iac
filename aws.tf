terraform {
  backend "s3" {
    bucket = "gds-digitalbackbone-dns-production-tfstate"
    key    = "cyber-profession.gov.uk-dns-iac.tfstate"
    region = "eu-west-2"
  }
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"

  default_tags {
    tags = local.default_tags
  }
}
