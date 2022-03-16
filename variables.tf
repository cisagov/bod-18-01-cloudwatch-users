# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "bod_lambdas" {
  description = "A map whose keys are the names of the BOD scan types and whose values are the names of the corresponding AWS Lambdas. Example: { \"pshtt\" = \"task_pshtt\" }"
  type        = map(string)
}

variable "users" {
  description = "A list of the usernames for the users that should be given access to the BOD 18-01 CloudWatch logs. Example: [\"firstname1.lastname1\", \"firstname2.lastname2\"]"
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

variable "bod_log_watchers_group_name" {
  default     = "bod_log_watchers"
  description = "The base name of the group to be created for BOD 18-01 Lambda log access users. Note that in production workspaces, '-production' is automatically appended this group name.  In non-production workspaces, '-<workspace_name>' is automatically appended to this group name."
  type        = string
}

variable "bodlambdalogreadaccess_policy_description" {
  default     = "Allows read access to the BOD 18-01 Lambda logs."
  description = "The description to associate with the IAM policy that allows read access to the BOD 18-01 Lambda logs."
  type        = string
}

variable "bodlambdalogreadaccess_policy_name" {
  default     = "BODLambdaLogReadAccess"
  description = "The base name to associate with the IAM policy that allows read access to the BOD 18-01 Lambda logs. Note that in production workspaces, '-production' is automatically appended this policy name.  In non-production workspaces, '-<workspace_name>' is automatically appended to this policy name."
  type        = string

}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}
