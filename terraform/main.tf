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
  db_security_group_id = module.vpc.db_security_group_id
}

module "ec2" {
  source = "./modules/ec2"

  wordpress_ami = var.wordpress_ami
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id = module.vpc.vpc_id
  availability_zones = var.availability_zones
  wordpress_sg = module.vpc.wordpress_sg
  lb_sg_id = module.vpc.lb_sg_id
  bastion_sg_id = module.vpc.bastion_sg_id
}