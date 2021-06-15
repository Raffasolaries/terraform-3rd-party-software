/* RDS database */
/* Subnets */
resource "aws_db_subnet_group" "rds_private_subnet" {
 count = var.relational_db == true ? 1 : 0 
 name = "${var.environment}-${var.app_name}-rds-private-subnet-group"
 subnet_ids = var.private_subnet_ids
}
/* Security Group allowing instance connection */
resource "aws_db_security_group" "rds_sg" {
 count = var.relational_db == true ? 1 : 0 
 name = "${var.environment}-${var.app_name}-rds-sg"

 ingress {
  security_group_id = var.instance_security_group_id
 }
}
resource "aws_rds_cluster" "postgresql" {
 count = var.relational_db == true ? 1 : 0
 cluster_identifier      = "aurora-cluster-demo"
 engine                  = var.db_type == "mysql" ? "aurora-mysql" : "aurora-postgresql"
 engine_mode             = "serverless"
 availability_zones      = var.availability_zones
 database_name           = "${var.environment}-${var.app_name}-rds"
 master_username         = "foo"
 master_password         = "bar"
 backup_retention_period = var.db_backup_retention_period
 preferred_backup_window = var.db_backup_window
 vpc_security_group_ids  = [aws_db_security_group.rds_sg.id]
 db_subnet_group_name    = aws_db_subnet_group.rds_private_subnet.name
}
