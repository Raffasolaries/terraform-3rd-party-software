## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_security_group) | resource |
| [aws_db_subnet_group.rds_private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_dynamodb_table.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_rds_cluster.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_secretsmanager_secret.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Application name | `string` | n/a | yes |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | (Only relational\_db == true) list all the used availability zones | `list` | n/a | yes |
| <a name="input_db_backup_retention_period"></a> [db\_backup\_retention\_period](#input\_db\_backup\_retention\_period) | (Only relational\_db == true) The days to retain backups for | `number` | `1` | no |
| <a name="input_db_backup_window"></a> [db\_backup\_window](#input\_db\_backup\_window) | (Only relational\_db == true) The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC. Default: A 30-minute window selected at random from an 8-hour block of time per region. e.g. 04:00-09:00 | `string` | n/a | yes |
| <a name="input_db_credentials"></a> [db\_credentials](#input\_db\_credentials) | (Only relational\_db == true) RDS Aurora master\_username & master\_password | <pre>object({<br>  master_username = string<br>  master_password = string<br> })</pre> | n/a | yes |
| <a name="input_db_hash_key"></a> [db\_hash\_key](#input\_db\_hash\_key) | (Only relational\_db == false) The attribute to use as the hash (partition) key. Must also be defined as an attribute | `string` | n/a | yes |
| <a name="input_db_range_key"></a> [db\_range\_key](#input\_db\_range\_key) | (Only relational\_db == false) The attribute to use as the range (sort) key. Must also be defined as an attribute | `string` | n/a | yes |
| <a name="input_db_type"></a> [db\_type](#input\_db\_type) | (Only relational\_db == true) Database type could be <mysql> or <postgresql> | `string` | `"postgresql"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | referral environment | `string` | n/a | yes |
| <a name="input_instance_security_group_id"></a> [instance\_security\_group\_id](#input\_instance\_security\_group\_id) | (Only relational\_db == true) Application instance security group id | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | (Only relational\_db == true) list of subnets ids where the RDS instances should be running | `list` | n/a | yes |
| <a name="input_relational_db"></a> [relational\_db](#input\_relational\_db) | Choose whether is a relational database or not | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_arn"></a> [database\_arn](#output\_database\_arn) | n/a |