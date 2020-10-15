output "db_name_arn" {
    value = aws_ssm_parameter.db_name.arn
}

output "db_username_arn" {
    value = aws_ssm_parameter.db_username.arn
}

output "db_password_arn" {
    value = aws_ssm_parameter.db_password.arn
}

output "parameters_key_arn" {
    value = aws_kms_key.this.arn
}