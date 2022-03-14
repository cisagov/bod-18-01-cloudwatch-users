# Fetch all users listed in var.users
data "aws_iam_user" "users" {
  for_each = toset(var.users)

  user_name = each.value
}

# Put the users in the IAM group that gives them permission to read
# the BOD 18-091 Lambda logs.
resource "aws_iam_user_group_membership" "user" {
  count = length(var.users)

  user = data.aws_iam_user.users[count.index].name

  groups = [
    aws_iam_group.bod_log_watchers.name,
  ]
}
