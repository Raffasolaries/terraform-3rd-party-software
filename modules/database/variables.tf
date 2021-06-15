variable "relational_db" {
 description = "Choose whether is a relational database or not"
 type = bool
 default = true
}

variable "db_type" {
 description = "(Only relational_db == true) Database type could be <mysql> or <postgresql>"
 type = bool
 default = "postgresql"
}

variable "environment" {
 type = string
 description = "referral environment"
}

variable "app_name" {
 description = "Application name"
 type = string
}

variable "availability_zones" {
 type = list
 description = "(Only relational_db == true) list all the used availability zones"
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

variable "db_master_username" {
 description = "(Only relational_db == true) Username for the master DB user"
 type = string
}

variable "db_master_password" {
 description = "(Only relational_db == true) Username for the master DB user"
 type = string
}

variable "db_hash_key" {
 description = "(Only relational_db == false) The attribute to use as the hash (partition) key. Must also be defined as an attribute"
 type = string
}

variable "db_range_key" {
 description = "(Only relational_db == false) The attribute to use as the range (sort) key. Must also be defined as an attribute"
 type = string
}