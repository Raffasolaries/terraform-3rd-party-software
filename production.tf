module "networking" {
 source               = "./modules/networking"
 region               = var.region
 environment          = var.environment
 app_name             = var.app_name
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
 public_subnet_ids   = module.networking.public_subnet_ids
 instance_id          = module.instance.instance_id
}

module "instance" {
 source =             "./modules/instance"
 environment          = var.environment
 ami_id               = var.ami_id
 app_name             = var.app_name
 instance_type        = var.instance_type
 vpc_id               = module.networking.vpc_id
 subnet_id            = element(module.networking.public_subnet_ids, 1)
 public_subnets_cidr  = var.public_subnets_cidr
 private_subnets_cidr = var.private_subnets_cidr
 key_path             = var.key_path
 volume_type          = var.volume_type
 volume_size          = var.volume_size
}

module "database" {
 source                      = "./modules/database"
 environment                 = var.environment
 app_name                    = var.app_name
 private_subnet_ids          = module.networking.private_subnet_ids
 db_type                     = var.db_type
 relational_db               = var.relational_db
 vpc_id                      = module.networking.vpc_id
 instance_security_group_id  = module.instance.instance_security_group_id
 availability_zones          = local.production_availability_zones
 db_backup_retention_period  = var.db_backup_retention_period
 db_backup_window            = var.db_backup_window
 db_credentials              = var.db_credentials
 db_hash_key                 = var.db_hash_key
 db_range_key                = var.db_range_key
}