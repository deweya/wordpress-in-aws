variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of private subnet IDs"
}

variable "db_security_group_id" {
  type        = string
  description = "The security group ID that the database will use"
}

variable "db_name" {
  type        = string
  description = "The name of the database"
}

variable "db_username" {
  type        = string
  description = "The db username"
}

variable "db_password" {
  type        = string
  description = "The db password"
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of AZs to provision subnets to"
}

variable "common_tags" {
  type        = map(string)
  description = "A set of common tags"
}

variable "rds_multi_az" {
  type = bool
  description = "Determines if the RDS database should be deployed across AZs"
}