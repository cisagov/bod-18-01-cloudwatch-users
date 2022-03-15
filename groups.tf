# An IAM group for all the folks who want read-only access to the BOD
# 18-01 scanning logs.
resource "aws_iam_group" "bod_log_watchers" {
  name = "bod_log_watchers"
}

# The CloudWatch log policy for our IAM group that lets the users view
# the BOD 18-01 Lambda logs.
resource "aws_iam_group_policy" "bod_log_watchers" {
  group  = aws_iam_group.bod_log_watchers.id
  policy = data.aws_iam_policy_document.bodlambdalogreadaccess_policy_doc.json
}
