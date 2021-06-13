variable "region" {
 description = "AWS Deployment region"
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
 type = list(string)
 description = "cidr blocks for public subnets"
}

variable "private_subnets_cidr" {
 type = list(string)
 description = "cidr blocks for private subnets"
}

variable "availability_zones" {
 type = list(string)
 description = "list all the used availability zones"
}

variable "app_name" {
 description = "Application name"
 type = string
}

variable "instance_type" {
 description = "Instance type"
 type = string
}

variable "certificate_arn" {
 description = "TLS certificate"
 type = string
}

variable "key_path" {
 description = "Path where ssh keys are located"
 type = string
}