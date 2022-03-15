# ------------------------------------------------------------------------------
# Retrieve the effective Account ID, User ID, and ARN in which
# Terraform is authorized.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}

# Import some data about the already-existing log groups
data "aws_cloudwatch_log_group" "bod_lambda_logs" {
  count = length(var.scan_types)

  name = "/aws/lambda/${var.lambda_function_names[var.scan_types[count.index]]}"
}

locals {
  # Determine if this is a Production workspace by checking
  # if terraform.workspace begins with "prod-"
  production_workspace = length(regexall("^prod-", terraform.workspace)) == 1

  bod_log_watchers_group_name = local.production_workspace ? format("%s-production", var.bod_log_watchers_group_name) : format("%s-%s", var.bod_log_watchers_group_name, terraform.workspace)

  bodlambdalogreadaccess_policy_name = local.production_workspace ? format("%s-production", var.bodlambdalogreadaccess_policy_name) : format("%s-%s", var.bodlambdalogreadaccess_policy_name, terraform.workspace)
}
