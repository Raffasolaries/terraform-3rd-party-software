module "networking" {
 source               = "./modules/networking"
 region               = var.region
 environment          = var.environment
 vpc_cidr             = var.vpc_cidr
 public_subnets_cidr  = var.public_subnets_cidr
 private_subnets_cidr = var.private_subnets_cidr
 availability_zones   = local.production_availability_zones
}

module "load_balancing" {
 source       = "./modules/load_balancing"
 environment  = var.environment
 app_name     = var.app_name
}

module "instance" {
 source =             "./modules/instance"
 environment          = var.environment
 app_name             = var.app_name
 instance_type        = var.instance_type
 public_subnets_cidr  = var.public_subnets_cidr
 private_subnets_cidr = var.private_subnets_cidr
 key_path             = var.key_path
}