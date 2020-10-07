provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "./modules/vpc"

  availability_zones = var.availability_zones
}

module "rds" {
  source = "./modules/rds"

  private_subnet_ids = module.vpc.private_subnet_ids
}