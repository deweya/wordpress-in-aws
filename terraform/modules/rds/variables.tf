variable "private_subnet_ids" {
    type = list(string)
    description = "A list of private subnet IDs"
}

variable "db_security_group_id" {
    type = string
    description = "The security group ID that the database will use"
}

variable "db_name" {
    type = string
    description = "The name of the database"
}

variable "db_username" {
    type = string
    description = "The db username"
}

variable "db_password" {
    type = string
    description = "The db password"
}