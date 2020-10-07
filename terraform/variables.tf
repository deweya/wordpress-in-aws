variable "availability_zones" {
    type = list(string)
    description = "A list of AZs to provision subnets to"
}

variable "wordpress_ami" {
    type = string
    description = "Name of wordpress AMI"
}