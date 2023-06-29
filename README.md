# A Terraform module to create a Redis ElastiCache cluster

[![Lint Status](https://github.com/Flaconi/terraform-aws-elasticache-redis/actions/workflows/linting.yml/badge.svg?branch=master)](https://github.com/Flaconi/terraform-aws-elasticache-redis/actions/workflows/linting.yml)
[![Docs Status](https://github.com/Flaconi/terraform-aws-elasticache-redis/actions/workflows/terraform-docs.yml/badge.svg?branch=master)](https://github.com/Flaconi/terraform-aws-elasticache-redis/actions/workflows/terraform-docs.yml)
[![Tag](https://img.shields.io/github/tag/Flaconi/terraform-aws-elasticache-redis.svg)](https://github.com/Flaconi/terraform-aws-elasticache-redis/releases)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A terraform module providing a Redis ElastiCache cluster in AWS.

This module

- Creates Redis ElastiCache clusters
- Creates, manages, and exports a security group

## Usage

```hcl
module "redis" {
  source         = "github.com/terraform-community-modules/tf_aws_elasticache_redis?ref=v1.3.0"
  env            = "${var.env}"
  name           = "thtest"
  redis_clusters = "2"
  redis_failover = "true"
  subnets        = "${module.vpc.database_subnets}"
  vpc_id         = "${module.vpc.vpc_id}"
}
```

## Usage with redis_parameters

```hcl
variable "redis_parameters" {
  description = "additional parameters"
  default = [{
    name  = "min-slaves-max-lag"
    value = "5"
  },{
    name  = "min-slaves-to-write"
    value = "1"
  },{
    name  = "databases"
    value = "32"
  }]
}

module "redis" {
  source           = "github.com/Flaconi/terraform-aws-elasticache-redis?ref=v0.2.0"
  ...
  redis_parameters = "${var.redis_parameters}"
  ...
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_parameter_group.redis_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.redis_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [random_id.salt](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | env to deploy into, should typically dev/staging/prod | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for the Redis replication group i.e. UserObject | `string` | n/a | yes |
| <a name="input_redis_clusters"></a> [redis\_clusters](#input\_redis\_clusters) | Number of Redis cache clusters (nodes) to create | `number` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of VPC Subnet IDs for the cache subnet group | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |
| <a name="input_allowed_cidr"></a> [allowed\_cidr](#input\_allowed\_cidr) | A list of Security Group ID's to allow access to. | `list(string)` | <pre>[<br>  "127.0.0.1/32"<br>]</pre> | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false. | `bool` | `false` | no |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | Specifies whether to enable Multi-AZ Support for the replication group | `bool` | `false` | no |
| <a name="input_redis_failover"></a> [redis\_failover](#input\_redis\_failover) | Specifies whether cluster should perform automatic fail-over | `bool` | `false` | no |
| <a name="input_redis_maintenance_window"></a> [redis\_maintenance\_window](#input\_redis\_maintenance\_window) | Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period | `string` | `"fri:08:00-fri:09:00"` | no |
| <a name="input_redis_node_type"></a> [redis\_node\_type](#input\_redis\_node\_type) | Instance type to use for creating the Redis cache clusters | `string` | `"cache.t2.micro"` | no |
| <a name="input_redis_parameters"></a> [redis\_parameters](#input\_redis\_parameters) | Additional parameters modified in parameter group | `list(map(string))` | `[]` | no |
| <a name="input_redis_port"></a> [redis\_port](#input\_redis\_port) | Which port redis will be listening on | `number` | `6379` | no |
| <a name="input_redis_snapshot_retention_limit"></a> [redis\_snapshot\_retention\_limit](#input\_redis\_snapshot\_retention\_limit) | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot\_retention\_limit is not supported on cache.t1.micro or cache.t2.* cache nodes | `number` | `0` | no |
| <a name="input_redis_snapshot_window"></a> [redis\_snapshot\_window](#input\_redis\_snapshot\_window) | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period | `string` | `"06:30-07:30"` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | Redis version to use, defaults to 3.2.10 | `string` | `"3.2.10"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A list of Security Group ID's to allow access to. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for redis nodes | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_enabled"></a> [cluster\_enabled](#output\_cluster\_enabled) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_endpoint_config"></a> [endpoint\_config](#output\_endpoint\_config) | n/a |
| <a name="output_endpoint_ro"></a> [endpoint\_ro](#output\_endpoint\_ro) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_parameter_group"></a> [parameter\_group](#output\_parameter\_group) | n/a |
| <a name="output_port"></a> [port](#output\_port) | n/a |
| <a name="output_redis_subnet_group_name"></a> [redis\_subnet\_group\_name](#output\_redis\_subnet\_group\_name) | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Created by [Tim Hartmann](https://github.com/tfhartmann). Maintained by [Anton Babenko](https://github.com/antonbabenko) and [these awesome contributors](https://github.com/terraform-community-modules/tf_aws_elasticache_redis/graphs/contributors).

## License

[MIT License](LICENSE)
