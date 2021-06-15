output "database_arn" {
 value = var.relational_db == true ? aws_rds_cluster.aurora[0].arn : aws_dynamodb_table.db[0].arn
}