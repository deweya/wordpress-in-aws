variable "wordpress_ami" {
  type        = string
  description = "Name of wordpress AMI"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "A list of public subnet IDs"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of private subnet IDs"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of AZs to provision subnets to"
}

variable "wordpress_sg" {
  type        = string
  description = "The security group to use for wordpress ec2 instances"
}

variable "lb_sg_id" {
  type        = string
  description = "The security group to use for the application load balancer"
}

variable "bastion_sg_id" {
  type        = string
  description = "The security group that the bastion will use"
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

variable "db_host" {
  type        = string
  description = "The db host"
}

variable "key_pair" {
  type        = string
  description = "The key pair to use for SSH into bastion and wordpress instances"
  default     = ""
}