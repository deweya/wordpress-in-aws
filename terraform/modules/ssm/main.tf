resource "aws_ssm_parameter" "db_name" {
    name = "db_name"
    value = var.db_name

    type = "String"
}

resource "aws_ssm_parameter" "db_username" {
    name = "db_username"
    value = var.db_username

    type = "String"
}

resource "aws_ssm_parameter" "db_password" {
    name = "db_password"
    value = var.db_password

    type = "String"
}