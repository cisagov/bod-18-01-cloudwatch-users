# IAM policy documents that allow reading of CloudWatch logs related
# to BOD 18-01 scanning.  This will be applied to the IAM group we are
# creating.
data "aws_iam_policy_document" "bodlambdalogreadaccess_policy_doc" {
  # Allow listing of CloudWatch log groups.
  statement {
    effect = "Allow"

    actions = [
      "logs:DescribeLogGroups",
    ]

    resources = [
      "*",
    ]
  }

  # Allow access to the individual log groups
  statement {
    effect = "Allow"

    actions = [
      "logs:DescribeLogStreams",
      "logs:FilterLogEvents",
      "logs:GetLogEvents",
    ]

    resources = [for k, v in data.aws_cloudwatch_log_group.bod_lambda_logs : v.arn]
  }
}

# The policy that allows read access to the BOD 18-01 Lambda logs
resource "aws_iam_policy" "bodlambdalogreadaccess_policy" {
  description = var.bodlambdalogreadaccess_policy_description
  name        = local.bodlambdalogreadaccess_policy_name
  policy      = data.aws_iam_policy_document.bodlambdalogreadaccess_policy_doc.json
}
