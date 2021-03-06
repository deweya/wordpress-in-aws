resource "aws_ssm_parameter" "db_name" {
    name = "db_name"
    value = var.db_name
    type = "String"
}

resource "aws_ssm_parameter" "db_username" {
    name = "db_username"
    value = var.db_username
    type = "SecureString"
    key_id = aws_kms_key.this.id
}

resource "aws_ssm_parameter" "db_password" {
    name = "db_password"
    value = var.db_password
    type = "SecureString"
    key_id = aws_kms_key.this.id
}

data "aws_caller_identity" "this" {}

resource "aws_kms_key" "this" {
    description = "For encrypting and decrypting wordpress-related parameters"
    deletion_window_in_days = 7

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Sid": "Allow access for Account Holder",
    "Effect": "Allow",
    "Principal": {
        "AWS": "${data.aws_caller_identity.this.arn}"
    },
    "Action": [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion",
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*"
    ],
    "Resource": "*"
    }
  ]
}
EOF
}