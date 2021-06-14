variable "environment" {
 type = string
 description = "Referral environment"
}

variable "app_name" {
 description = "Application name"
 type = string
}

variable "certificate_arn" {
 description = "TLS certificate"
 type = string
}

variable "vpc_id" {
 description = "The ID of the VPC"
 type = string
}

variable "public_subnets" {
 description = "Public subnets IDs"
 type = string
}

variable "instance_id" {
 description = "Instance ID"
 type = string
}


