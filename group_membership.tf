# Put the users in the IAM group that gives them permission to read
# the BOD 18-01 Lambda logs.
resource "aws_iam_user_group_membership" "user" {
  for_each = toset(var.users)

  user = data.aws_iam_user.users[each.value].user_name

  groups = [
    aws_iam_group.bod_log_watchers.name,
  ]
}
