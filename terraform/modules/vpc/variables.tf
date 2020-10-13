variable "availability_zones" {
  type        = list(string)
  description = "A list of AZs to provision subnets to"
}

variable "common_tags" {
  type        = map(string)
  description = "A set of common tags"
}

variable "deploy_wp_to_private_subnet" {
  type = bool
  description = "Determines if WordPress should be deployed to a private subnet behind a NAT gateway"
}

variable "deploy_bastion" {
  type = bool
  description = "Determines if bastion(s) should be deployed to the public subnet(s)"
}