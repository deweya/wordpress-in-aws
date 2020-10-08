variable "wordpress_ami" {
    type = string
    description = "Name of wordpress AMI"
}

variable "public_subnet_ids" {
    type = list(string)
    description = "A list of public subnet IDs"
}

variable "private_subnet_ids" {
    type = list(string)
    description = "A list of private subnet IDs"
}

variable "vpc_id" {
    type = string
    description = "The VPC ID"
}

variable "availability_zones" {
    type = list(string)
    description = "A list of AZs to provision subnets to"
}

variable "wordpress_sg" {
    type = string
    description = "The security group to use for wordpress ec2 instances"
}

variable "lb_sg_id" {
    type = string
    description = "The security group to use for the application load balancer"
}