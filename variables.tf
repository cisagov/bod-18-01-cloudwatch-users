# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "lambda_function_names" {
  description = "The names to use for the AWS Lambda functions.  The keys should match the contents of scan_types and the values should be the name of the corresponding Lamba. Example: { \"pshtt\" = \"task_pshtt\" }"
  type        = map(string)
}

variable "scan_types" {
  description = "The scan types that can be run. Example: [\"pshtt\"]"
  type        = list(string)
}

variable "usernames" {
  description = "The usernames associated with the accounts to be created.  The format first.last is recommended. Example: [\"firstname1.lastname1\", \"firstname2.lastname2\"]"
  type        = list(string)
}


# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_availability_zone" {
  default     = "a"
  description = "The AWS availability zone to deploy into (e.g. a, b, c, etc.)."
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region to deploy into (e.g. us-east-1)."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}
