# The users being created
resource "aws_iam_user" "user" {
  count = "${length(var.usernames)}"

  name = "${var.usernames[count.index]}"
  tags = "${var.tags}"
}

# Put the users in the IAM group that gives them permission to read
# the BOD 18-091 Lambda logs.
resource "aws_iam_user_group_membership" "user" {
  count = "${length(var.usernames)}"

  user = "${aws_iam_user.user.*.name[count.index]}"

  groups = [
    "${aws_iam_group.bod_log_watchers.name}",
  ]
}

# IAM policy that allows the users to administer their own user
# accounts.
data "aws_iam_policy_document" "iam_self_admin_doc" {
  count = "${length(var.usernames)}"

  statement {
    effect = "Allow"

    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:ListVirtualMFADevices",
    ]

    resources = [
      "*",
    ]
  }

  # Allow users to administer their own passwords
  statement {
    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:GetUser",
    ]

    resources = [
      "${aws_iam_user.user.*.arn[count.index]}",
    ]
  }

  # Allow users to administer their own access keys
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
    ]

    resources = [
      "${aws_iam_user.user.*.arn[count.index]}",
    ]
  }

  # Allow users to administer their own signing certificates
  statement {
    effect = "Allow"

    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
    ]

    resources = [
      "${aws_iam_user.user.*.arn[count.index]}",
    ]
  }

  # Allow users to administer their own ssh public keys
  statement {
    effect = "Allow"

    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]

    resources = [
      "${aws_iam_user.user.*.arn[count.index]}",
    ]
  }

  # Allow users to administer their own git credentials
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential",
    ]

    resources = [
      "${aws_iam_user.user.*.arn[count.index]}",
    ]
  }

  # Allow users to administer their own virtual MFA device
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
    ]

    resources = [
      "${aws_iam_user.user.*.arn[count.index]}",
    ]
  }

  # Allow users to administer their own (non-virtual) MFA device
  statement {
    effect = "Allow"

    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice",
    ]

    resources = [
      "${aws_iam_user.user.*.arn[count.index]}",
    ]
  }

  # Deny all actions but the following if no MFA device is configured
  statement {
    effect = "Deny"

    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "sts:GetSessionToken",
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"

      values = [
        false,
      ]
    }
  }
}

# The IAM self-administration policy for our IAM users
resource "aws_iam_user_policy" "user" {
  count = "${length(var.usernames)}"

  user   = "${aws_iam_user.user.*.name[count.index]}"
  policy = "${data.aws_iam_policy_document.iam_self_admin_doc.*.json[count.index]}"
}
