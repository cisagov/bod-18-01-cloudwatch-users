# An IAM group for all the folks who want read-only access to the BOD
# 18-01 scanning logs.
resource "aws_iam_group" "bod_log_watchers" {
  name = "bod_log_watchers"
}

# Import some data about the already-existing log groups
data "aws_cloudwatch_log_group" "bod_lambda_logs" {
  count = length(var.scan_types)

  name = "/aws/lambda/${var.lambda_function_names[var.scan_types[count.index]]}"
}

# IAM policy documents that allow reading of CloudWatch logs related
# to BOD 18-01 scanning.  This will be applied to the IAM group we are
# creating.
data "aws_iam_policy_document" "bod_lambda_log_doc" {
  count = length(var.scan_types)

  statement {
    effect = "Allow"

    actions = [
      "logs:DescribeLogStreams",
      "logs:FilterLogEvents",
      "logs:GetLogEvents",
    ]

    resources = [
      data.aws_cloudwatch_log_group.bod_lambda_logs[count.index].arn,
    ]
  }
}

# IAM policy document that allows listing of CloudWatch log groups.
# This will be applied to the IAM group we are creating.
data "aws_iam_policy_document" "list_log_doc" {
  statement {
    effect = "Allow"

    actions = [
      "logs:DescribeLogGroups",
    ]

    resources = [
      "*",
    ]
  }
}

# The CloudWatch log policy for our IAM group that lets the users view
# the BOD 18-01 Lambda logs.
resource "aws_iam_group_policy" "bod_log_watchers" {
  count = length(var.scan_types)

  group  = aws_iam_group.bod_log_watchers.id
  policy = data.aws_iam_policy_document.bod_lambda_log_doc[count.index].json
}

# The CloudWatch log policy for our IAM group that lets the users list
# the CloudWatch log groups associated with the account.
resource "aws_iam_group_policy" "list_logs" {
  group  = aws_iam_group.bod_log_watchers.id
  policy = data.aws_iam_policy_document.list_log_doc.json
}
