variable "region" {
 description = "AWS deployment region"
 type = string
 default = "eu-central-1"
}

variable "profile" {
 description = "AWS IAM user credentials"
 type = string
}

variable "environment" {
 type = string
 description = "referral environment"
}

variable "vpc_cidr" {
 type = string
 description = "CIDR VPC block"
}

variable "public_subnets_cidr" {
 type = list
 description = "cidr blocks for public subnets"
}

variable "private_subnets_cidr" {
 type = list
 description = "cidr blocks for private subnets"
}

variable "availability_zones" {
 type = list
 description = "list all the used availability zones"
}

variable "app_name" {
 description = "Application name"
 type = string
}

variable "ami_id" {
 description = "The AMI ID"
 type = string
}

variable "instance_type" {
 description = "Instance type"
 type = string
}

variable "volume_type" {
 description = "Type of volume. Valid values include standard, gp2, gp3, io1, io2, sc1, or st1. Defaults to gp2"
 type = string
}

variable "volume_size" {
 description = "Size of the volume in gibibytes (GiB)"
 type = number
}

variable "certificate_arn" {
 description = "TLS certificate"
 type = string
}

variable "key_path" {
 description = "Path where ssh keys are located"
 type = string
}

variable "relational_db" {
 description = "Choose whether is a relational database or not"
 type = bool
 default = true
}

variable "db_type" {
 description = "(Only relational_db == true) Database type could be <mysql> or <postgresql>"
 type = string
 default = "postgresql"
}

variable "db_backup_retention_period" {
 description = "(Only relational_db == true) The days to retain backups for"
 type = number
 default = 1
}

variable "db_backup_window" {
 description = "(Only relational_db == true) The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC. Default: A 30-minute window selected at random from an 8-hour block of time per region. e.g. 04:00-09:00"
 type = string
}

variable "db_credentials" {
 description = "(Only relational_db == true) RDS Aurora master_username & master_password"
 type = object({
  master_username = string
  master_password = string
 })
 sensitive = true
}

variable "db_hash_key" {
 description = "(Only relational_db == false) The attribute to use as the hash (partition) key. Must also be defined as an attribute"
 type = string
}

variable "db_range_key" {
 description = "(Only relational_db == false) The attribute to use as the range (sort) key. Must also be defined as an attribute"
 type = string
}