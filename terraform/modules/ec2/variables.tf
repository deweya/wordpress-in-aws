variable "wordpress_ami" {
    type = string
    description = "Name of wordpress AMI"
}

variable "public_subnet_ids" {
    type = list(string)
    description = "A list of public subnet IDs"
}

variable "vpc_id" {
    type = string
    description = "The VPC ID"
}