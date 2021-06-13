variable "environment" {
 type = string
 description = "Referral environment"
}

variable "public_subnets_cidr" {
 type = list(string)
 description = "cidr blocks for public subnets"
}

variable "private_subnets_cidr" {
 type = list(string)
 description = "cidr blocks for private subnets"
}

variable "app_name" {
 description = "Application name"
 type = string
}

variable "instance_type" {
 description = "Instance type"
 type = string
}