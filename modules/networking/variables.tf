variable "region" {
 description = "AWS Deployment region"
 type = string
}

variable "environment" {
 type = string
 description = "Referral environment"
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