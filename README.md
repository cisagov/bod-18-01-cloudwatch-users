# bod-18-01-cloudwatch-users #

[![GitHub Build Status](https://github.com/cisagov/bod-18-01-cloudwatch-users/workflows/build/badge.svg)](https://github.com/cisagov/bod-18-01-cloudwatch-users/actions)

This is a Terraform project for creating AWS users that only have
permission to view CloudWatch logs related to BOD 18-01 scanning.

## Pre-requisites ##

- [Terraform](https://www.terraform.io/) installed on your system.
- AWS CLI access
  [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
  for the appropriate account on your system.
- An accessible AWS S3 bucket to store Terraform state
  (specified in [`backend.tf`](backend.tf)).
- An accessible AWS DynamoDB database to store the Terraform state lock
  (specified in [`backend.tf`](backend.tf)).
- User accounts for all users must have been created previously. We recommend
  using the
  [`cisagov/cyhy-users-non-admin`](https://github.com/cisagov/cyhy-users-non-admin)
  repository to create users.

## Customizing Your Environment ##

Create a terraform variables file to be used for your environment (e.g.
  `production.tfvars`), based on the variables listed in [Inputs](#Inputs)
  below. Here is a sample of what that file might look like:

```hcl
aws_region = "us-east-2"

usernames = ["firstname1.lastname1", "firstname2.lastname2"]

scan_types = ["pshtt", "trustymail"]
lambda_function_names = {
  "pshtt"      = "task_pshtt",
  "trustymail" = "task_trustymail"
}

tags = {
  Team        = "CISA Development Team"
  Application = "BOD 18-01 Scanning"
  Workspace   = "production"
}
```

## Building the Terraform-based infrastructure ##

1. Create a Terraform workspace (if you haven't already done so) by running:

   ```console
   terraform workspace new <workspace_name>`
   ```

1. Create a `<workspace_name>.tfvars` file with all of the required
   variables and any optional variables desired (see [Inputs](#Inputs) below
   for details).
1. Run the command `terraform init`.
1. Create the Terraform infrastructure by running the command:

   ```console
   terraform apply -var-file=<workspace_name>.tfvars
   ```

## Tearing down the Terraform-based infrastructure ##

1. Select the appropriate Terraform workspace by running
   `terraform workspace select <workspace_name>`.
1. Destroy the Terraform infrastructure in that workspace by running
   `terraform destroy -var-file=<workspace_name>.tfvars`.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_group.bod_log_watchers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.bodlambdalogreadaccess_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.bodlambdalogreadaccess_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user_group_membership.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_cloudwatch_log_group.bod_lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudwatch_log_group) | data source |
| [aws_iam_policy_document.bodlambdalogreadaccess_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_user.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_user) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_availability\_zone | The AWS availability zone to deploy into (e.g. a, b, c, etc.). | `string` | `"a"` | no |
| aws\_region | The AWS region to deploy into (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| bod\_log\_watchers\_group\_name | The name of the group to be created for BOD 18-01 Lambda log access users. | `string` | `"bod_log_watchers"` | no |
| bodlambdalogreadaccess\_policy\_description | The description to associate with the IAM policy that allows read access to the BOD 18-01 Lambda logs. | `string` | `"Allows read access to the BOD 18-01 Lambda logs."` | no |
| bodlambdalogreadaccess\_policy\_name | The name to associate with the IAM policy that allows read access to the BOD 18-01 Lambda logs. | `string` | `"BODLambdaLogReadAccess"` | no |
| lambda\_function\_names | The names to use for the AWS Lambda functions.  The keys should match the contents of scan\_types and the values should be the name of the corresponding Lamba. Example: { "pshtt" = "task\_pshtt" } | `map(string)` | n/a | yes |
| scan\_types | The scan types that can be run. Example: ["pshtt"] | `list(string)` | n/a | yes |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| users | A list of the usernames for the users that should be given access to the BOD 18-01 CloudWatch logs. Example: ["firstname1.lastname1", "firstname2.lastname2"] | `list(string)` | n/a | yes |

## Outputs ##

No outputs.

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is only the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
