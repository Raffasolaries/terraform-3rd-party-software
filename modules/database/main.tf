/* RDS database */
/* Subnets */
resource "aws_db_subnet_group" "rds_private_subnet" {
 count = var.relational_db == true ? 1 : 0 
 name = "${var.environment}-${var.app_name}-rds-private-subnet-group"
 subnet_ids = var.private_subnet_ids
 tags = {
  Name = "${var.environment}-${var.app_name}-rds-private-subnet-group"
  Environment = var.environment
 }
}
/* Security Group allowing instance connection */
resource "aws_db_security_group" "rds_sg" {
 count = var.relational_db == true ? 1 : 0 
 name = "${var.environment}-${var.app_name}-rds-sg"
 ingress {
  security_group_id = var.instance_security_group_id
 }
 tags = {
  Name = "${var.environment}-${var.app_name}-rds-sg"
  Environment = var.environment
 }
}
/* Retrieve KMS secrets
/* Aurora Serverless cluster */
resource "aws_rds_cluster" "aurora" {
 count                   = var.relational_db == true ? 1 : 0
 cluster_identifier      = "${var.environment}-${var.app_name}-aurora-cluster"
 engine                  = var.db_type == "mysql" ? "aurora-mysql" : "aurora-postgresql"
 engine_mode             = "serverless"
 availability_zones      = var.availability_zones
 database_name           = "${var.environment}-${var.app_name}-rds"
 master_username         = var.db_credentials.master_username
 master_password         = var.db_credentials.master_password
 backup_retention_period = var.db_backup_retention_period
 preferred_backup_window = var.db_backup_window
 vpc_security_group_ids  = [aws_db_security_group.rds_sg[0].id]
 db_subnet_group_name    = aws_db_subnet_group.rds_private_subnet[0].name
 deletion_protection     = true
 scaling_configuration {
  max_capacity             = var.db_type == "mysql" ? 256 : 384
  min_capacity             = 2
  seconds_until_auto_pause = 300
  timeout_action           = "ForceApplyCapacityChange"
 }
 tags = {
  Name = "${var.environment}-${var.app_name}-aurora-cluster"
  Environment = var.environment
 }
}
/* Secrets Manager storing credential keys */
resource "aws_secretsmanager_secret" "rds" {
 count                     = var.relational_db == true ? 1 : 0
 name                      = "${var.environment}-${var.app_name}-aurora-secrets"
 tags = {
  Name = "${var.environment}-${var.app_name}-aurora-secrets"
  Environment = var.environment
 }
}
resource "aws_secretsmanager_secret_version" "rds" {
 count                   = var.relational_db == true ? 1 : 0
 secret_id               = aws_secretsmanager_secret.rds[0].id
 secret_string           = jsonencode(var.db_credentials)
}
/* Alternative DynamoDB database */
resource "aws_dynamodb_table" "db" {
 count                    = var.relational_db == false ? 1 : 0
 name                     = "${var.environment}-${var.app_name}-dynamodb-table"
 hash_key                 = var.db_hash_key
 range_key                = var.db_range_key
 billing_mode             = "PAY_PER_REQUEST"
 stream_enabled           = false
 point_in_time_recovery {
  enabled = true
 }
 attribute {
  name = var.db_hash_key
  type = "S"
 }
 attribute {
  name = var.db_range_key
  type = "S"
 }
 tags = {
  Name = "${var.environment}-${var.app_name}-dynamodb-table"
  Environment = var.environment
 }
}