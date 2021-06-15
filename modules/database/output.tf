output "database_arn" {
 value = var.relational_db == true ? aws_rds_cluster.aurora.arn : aws_dynamodb_table.db.arn
}