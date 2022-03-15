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
