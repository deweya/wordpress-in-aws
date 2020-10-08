variable "availability_zones" {
    type = list(string)
    description = "A list of AZs to provision subnets to"
}

variable "wordpress_ami" {
    type = string
    description = "Name of wordpress AMI"
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