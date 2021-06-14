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

variable "volume_type" {
 description = "Type of volume. Valid values include standard, gp2, gp3, io1, io2, sc1, or st1. Defaults to gp2"
 type = string
}

variable "volume_size" {
 description = "Size of the volume in gibibytes (GiB)"
 type = number
}

variable "key_path" {
 description = "Path where ssh keys are located"
 type = string
}