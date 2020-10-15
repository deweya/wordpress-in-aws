variable "db_name_arn" {
  type        = string
  description = "The arn of the database parameter"
}

variable "db_username_arn" {
  type        = string
  description = "The arn of the db username parameter"
}

variable "db_password_arn" {
  type        = string
  description = "The arn of the db password parameter"
}

variable "parameters_key_arn" {
  type = string
  description = "The arn of the parameters key for encrypting/decrypting parameters"
}