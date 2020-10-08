variable "availability_zones" {
  type        = list(string)
  description = "A list of AZs to provision subnets to"
}

variable "common_tags" {
  type        = map(string)
  description = "A set of common tags"
}