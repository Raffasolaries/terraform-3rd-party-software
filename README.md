
## Requirements

[Terraform](https://www.terraform.io)
[AWS CLI](https://github.com/aws/aws-cli)

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_database"></a> [database](#module\_database) | ./modules/database | n/a |
| <a name="module_instance"></a> [instance](#module\_instance) | ./modules/instance | n/a |
| <a name="module_load_balancing"></a> [load\_balancing](#module\_load\_balancing) | ./modules/load_balancing | n/a |
| <a name="module_networking"></a> [networking](#module\_networking) | ./modules/networking | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | The AMI ID | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Application name | `string` | n/a | yes |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | list all the used availability zones | `list` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | TLS certificate | `string` | n/a | yes |
| <a name="input_db_backup_retention_period"></a> [db\_backup\_retention\_period](#input\_db\_backup\_retention\_period) | (Only relational\_db == true) The days to retain backups for | `number` | `1` | no |
| <a name="input_db_backup_window"></a> [db\_backup\_window](#input\_db\_backup\_window) | (Only relational\_db == true) The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC. Default: A 30-minute window selected at random from an 8-hour block of time per region. e.g. 04:00-09:00 | `string` | n/a | yes |
| <a name="input_db_credentials"></a> [db\_credentials](#input\_db\_credentials) | (Only relational\_db == true) RDS Aurora master\_username & master\_password | <pre>object({<br>  master_username = string<br>  master_password = string<br> })</pre> | n/a | yes |
| <a name="input_db_hash_key"></a> [db\_hash\_key](#input\_db\_hash\_key) | (Only relational\_db == false) The attribute to use as the hash (partition) key. Must also be defined as an attribute | `string` | n/a | yes |
| <a name="input_db_range_key"></a> [db\_range\_key](#input\_db\_range\_key) | (Only relational\_db == false) The attribute to use as the range (sort) key. Must also be defined as an attribute | `string` | n/a | yes |
| <a name="input_db_type"></a> [db\_type](#input\_db\_type) | (Only relational\_db == true) Database type could be <mysql> or <postgresql> | `string` | `"postgresql"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | referral environment | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | n/a | yes |
| <a name="input_key_path"></a> [key\_path](#input\_key\_path) | Path where ssh keys are located | `string` | n/a | yes |
| <a name="input_private_subnets_cidr"></a> [private\_subnets\_cidr](#input\_private\_subnets\_cidr) | cidr blocks for private subnets | `list` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS IAM user credentials | `string` | n/a | yes |
| <a name="input_public_subnets_cidr"></a> [public\_subnets\_cidr](#input\_public\_subnets\_cidr) | cidr blocks for public subnets | `list` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS deployment region | `string` | `"eu-central-1"` | no |
| <a name="input_relational_db"></a> [relational\_db](#input\_relational\_db) | Choose whether is a relational database or not | `bool` | `true` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of the volume in gibibytes (GiB) | `number` | n/a | yes |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Type of volume. Valid values include standard, gp2, gp3, io1, io2, sc1, or st1. Defaults to gp2 | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR VPC block | `string` | n/a | yes |

