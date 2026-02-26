data "aws_iam_policy_document" "route53_cyber_profession_access" {
  statement {
    sid    = "ZoneReadWrite"
    effect = "Allow"
    actions = [
      "route53:GetHostedZone",
      "route53:ListResourceRecordSets",
      "route53:ChangeResourceRecordSets",
    ]
    resources = [aws_route53_zone.cyberprofessiongovuk.arn]
  }

  statement {
    sid    = "LookupAndChangeStatus"
    effect = "Allow"
    actions = [
      "route53:ListTagsForResource",
      "route53:ListHostedZonesByName",
      "route53:ListHostedZones",
      "route53:GetChange",
    ]
    resources = ["*"]
  }
}

// 265613950863 - dbb-apps-staging
// 130571707167 - dbb-apps-production

data "aws_iam_policy_document" "terraform_route53_cyber_profession_access_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::265613950863:role/wagtail-instances-terraform-deployment",
        "arn:aws:iam::265613950863:role/platform-admin",
        "arn:aws:iam::265613950863:role/dbb-apps-admin",
        "arn:aws:iam::130571707167:role/wagtail-instances-terraform-deployment",
        "arn:aws:iam::130571707167:role/platform-admin",
        "arn:aws:iam::130571707167:role/dbb-apps-admin",
      ]
    }
  }
}

resource "aws_iam_policy" "route53_cyber_profession_access" {
  name        = "route53-cyber-profession-policy"
  description = "Allows DBB apps roles to manage cyber-profession.gov.uk Route53 records."
  policy      = data.aws_iam_policy_document.route53_cyber_profession_access.json

  tags = merge(local.default_tags, {
    "Name" : "route53-cyber-profession-policy"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "terraform_route53_cyber_profession_access" {
  name               = "terraform-route53-cyber-profession-access"
  assume_role_policy = data.aws_iam_policy_document.terraform_route53_cyber_profession_access_trust.json

  tags = merge(local.default_tags, {
    "Name" : "terraform-route53-cyber-profession-access"
  })
}

resource "aws_iam_role_policy_attachment" "terraform_route53_cyber_profession_access" {
  role       = aws_iam_role.terraform_route53_cyber_profession_access.name
  policy_arn = aws_iam_policy.route53_cyber_profession_access.arn
}
