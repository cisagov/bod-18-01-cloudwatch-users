# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "lambda_function_names" {
  type        = map(string)
  description = "The names to use for the Lambda functions.  The keys are the values in scan_types."
}

variable "scan_types" {
  type        = list(string)
  description = "The scan types that can be run."
}

variable "usernames" {
  type        = list(string)
  description = "The usernames associated with the accounts to be created.  The format first.last is recommended."
}


# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_availability_zone" {
  description = "The AWS availability zone to deploy into (e.g. a, b, c, etc.)."
  default     = "a"
}

variable "aws_region" {
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}
