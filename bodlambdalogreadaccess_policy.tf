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

    resources = data.aws_cloudwatch_log_group.bod_lambda_logs[*].arn
  }
}
