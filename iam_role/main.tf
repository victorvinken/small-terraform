data "aws_iam_policy_document" "AssumeRolePolicy" {
    statement {
        sid = "1"

        effect = "Allow"

        actions = [
            "sts:AssumeRole"
        ]

        principals {
          type = "AWS"

          identifiers = [
              "arn:aws:iam::884866656237:root",
              "arn:aws:iam::627743545735:root"
          ]
        }

    }
}

resource "aws_iam_role" "SpotFinOpsRole" {
    name = "SpotFinOpsRole"

    assume_role_policy = data.aws_iam_policy_document.AssumeRolePolicy.json

    managed_policy_arns = [
        var.SpotFinOpsManagedPolicy,
        "arn:aws:iam::aws:policy/job-function/Billing",
        "arn:aws:iam::aws:policy/AWSCloudFormationReadOnlyAccess",
        "arn:aws:iam::aws:policy/ServiceQuotasFullAccess",
    ]
}