# An IAM group for all the folks who want read-only access to the BOD
# 18-01 scanning logs.
resource "aws_iam_group" "bod_log_watchers" {
  name = var.bod_log_watchers_group_name
}

resource "aws_iam_group_policy_attachment" "bodlambdalogreadaccess_policy_attachment" {
  group      = aws_iam_group.bod_log_watchers.id
  policy_arn = aws_iam_policy.bodlambdalogreadaccess_policy.arn
}
