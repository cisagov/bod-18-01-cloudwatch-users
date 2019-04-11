variable "aws_region" {
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "aws_availability_zone" {
  description = "The AWS availability zone to deploy into (e.g. a, b, c, etc.)."
  default     = "a"
}

variable "tags" {
  type        = "map"
  description = "Tags to apply to all AWS resources created"
  default     = {}
}

variable "scan_types" {
  type        = "list"
  description = "The scan types that can be run."
}

variable "lambda_function_names" {
  type        = "map"
  description = "The names to use for the Lambda functions.  The keys are the values in scan_types."
}

variable "usernames" {
  type        = "list"
  description = "The usernames associated with the accounts to be created.  The format first.last is recommended."
}
