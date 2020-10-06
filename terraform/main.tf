provider "aws" {
  region = "us-east-2"
}

module "vpc" {
    source = "./modules/vpc"

    availability_zones = var.availability_zones
}