# ------------------------------------------------------------------------------
# Retrieve the effective Account ID, User ID, and ARN in which
# Terraform is authorized.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}
