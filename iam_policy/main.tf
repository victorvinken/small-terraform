data "aws_iam_policy_document" "PolicyDoc" {
  statement {
    sid = "FullPolicy"

    effect = "Allow"

    actions = [
        "cloudformation:DescribeStacks",
        "cloudformation:GetStackPolicy",
        "cloudformation:GetTemplate",
        "cloudformation:ListStackResources",
        "dynamodb:List*",
        "dynamodb:Describe*",
        "savingsplans:List*",
        "savingsplans:Describe*",
        "ec2:Describe*",
        "ec2:List*",
        "ec2:GetHostReservationPurchasePreview",
        "ec2:GetReservedInstancesExchangeQuote",
        "elasticache:List*",
        "elasticache:Describe*",
        "es:List*",
        "es:Describe*",
        "cur:*",
        "ce:*",
        "rds:Describe*",
        "rds:ListTagsForResource",
        "redshift:Describe*",
        "trustedadvisor:*",
        "support:*",
        "organizations:List*",
        "organizations:Describe*"
    ]

    resources = [
        "*"
    ]
  }

  statement {
    sid = "S3SyncPermissions"

    effect = "Allow"

    actions = [
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads",
        "s3:AbortMultipartUpload",
        "s3:ListMultipartUploadParts",
        "s3:PutObject",
        "s3:List*",
        "s3:ListBucket",
        "s3:PutObjectTagging",
        "s3:PutObjectAcl"
    ]

    resources = [
        "arn:aws:s3:::sc-customer-*"
    ]
  }

  statement {
    sid = "S3BillingDBR"

    effect = "Allow"

    actions = [
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads",
        "s3:AbortMultipartUpload",
        "s3:ListMultipartUploadParts",
        "s3:List*",
        "s3:get*"
    ]

    resources = [
        join("", ["arn:aws:s3:::", "${var.Cost_and_Usage_bucket_name}", "*"]),
        join("", ["arn:aws:s3:::", "${var.Cost_and_Usage_bucket_name}", "/*"])
    ]
  }

  statement {
    sid = "ServiceQuotas"

    effect = "Allow"

    actions = [
        "servicequotas:*",
    ]

    resources = [
        "*"
    ]
  }
}

resource "aws_iam_policy" "SpotFinOpsManagedPolicy" {
    name = "SpotFinOpsManagedPolicy"

    path = "/"

    description = "SC Account Policy"

    policy = data.aws_iam_policy_document.PolicyDoc.json
  
}