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
 source               = "./modules/load_balancing"
 environment          = var.environment
 app_name             = var.app_name
 certificate_arn      = var.certificate_arn
 vpc_id               = module.networking.vpc_id
 public_subnets_ids   = module.networking.public_subnets_ids
 instance_id          = module.instance.instance_id
}

module "instance" {
 source =             "./modules/instance"
 environment          = var.environment
 app_name             = var.app_name
 instance_type        = var.instance_type
 vpc_id               = module.networking.vpc_id
 subnet_id            = element(module.networking.public_subnets_ids, 1)
 public_subnets_cidr  = var.public_subnets_cidr
 private_subnets_cidr = var.private_subnets_cidr
 key_path             = var.key_path
 volume_type          = var.volume_type
 volume_size          = var.volume_size
}