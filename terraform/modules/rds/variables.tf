variable "private_subnet_ids" {
    type = list(string)
    description = "A list of private subnet IDs"
}

variable "db_security_group_id" {
    type = string
    description = "The security group ID that the database will use"
}