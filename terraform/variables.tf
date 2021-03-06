variable "availability_zones" {
  type        = list(string)
  description = "A list of AZs to provision subnets to"
}

variable "wordpress_ami" {
  type        = string
  description = "Name of wordpress AMI"
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

variable "deploy_bastion" {
  type = bool
  description = "Determines if bastion(s) should be deployed"
}

variable "deploy_wp_to_private_subnet" {
  type = bool
  description = "Determines if WordPress should be deployed to a private subnet behind a NAT gateway"
}

variable "rds_multi_az" {
  type = bool
  description = "Determines if the RDS database should be deployed across AZs"
}

variable "key_pair" {
  type        = string
  description = "The key pair to use for SSH into bastion and wordpress instances"
  default     = ""
}