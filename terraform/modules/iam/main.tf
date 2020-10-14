resource "aws_iam_role" "get_parameters" {
    name = "get_parameters"
    description = "Role to permit ec2 to get parameters from Parameter Store"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "get_parameters" {
    name = "get_parameters"
    role = aws_iam_role.get_parameters.name

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameters"
            ],
            "Resource": [
                "${var.db_name_arn}",
                "${var.db_username_arn}",
                "${var.db_password_arn}"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "get_parameters" {
    name = "get_parameters"
    role = aws_iam_role.get_parameters.name
}