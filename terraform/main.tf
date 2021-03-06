locals {
  common_tags = map("app", "wordpress")
}

provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "./modules/vpc"

  availability_zones = var.availability_zones
  common_tags        = local.common_tags
  deploy_wp_to_private_subnet = var.deploy_wp_to_private_subnet
  deploy_bastion = var.deploy_bastion
}

module "ssm" {
  source = "./modules/ssm"

  db_name = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
}

module "iam" {
  source = "./modules/iam"

  db_name_arn = module.ssm.db_name_arn
  db_username_arn = module.ssm.db_username_arn
  db_password_arn = module.ssm.db_password_arn
  parameters_key_arn = module.ssm.parameters_key_arn
}

module "rds" {
  source = "./modules/rds"

  private_subnet_ids   = module.vpc.private_subnet_ids
  db_security_group_id = module.vpc.db_security_group_id
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  availability_zones   = var.availability_zones
  common_tags          = local.common_tags
  rds_multi_az = var.rds_multi_az
}

module "ec2" {
  source = "./modules/ec2"

  wordpress_ami      = var.wordpress_ami
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  availability_zones = var.availability_zones
  wordpress_sg       = module.vpc.wordpress_sg
  lb_sg_id           = module.vpc.lb_sg_id
  bastion_sg_id      = module.vpc.bastion_sg_id
  db_host            = module.rds.db_host
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  key_pair           = var.key_pair
  common_tags        = local.common_tags
  deploy_wp_to_private_subnet = var.deploy_wp_to_private_subnet
  deploy_bastion = var.deploy_bastion
  instance_profile_name = module.iam.instance_profile_name
}