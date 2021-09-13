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
  source           = "github.com/terraform-community-modules/tf_aws_elasticache_redis?ref=v1.3.0"
  ...
  redis_parameters = "${var.redis_parameters}"
  ...
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| aws | >= 3 |
| random | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3 |
| random | >= 3.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| env | env to deploy into, should typically dev/staging/prod | `string` | n/a | yes |
| name | Name for the Redis replication group i.e. UserObject | `string` | n/a | yes |
| redis\_clusters | Number of Redis cache clusters (nodes) to create | `number` | n/a | yes |
| subnets | List of VPC Subnet IDs for the cache subnet group | `list(string)` | n/a | yes |
| vpc\_id | VPC ID | `string` | n/a | yes |
| allowed\_cidr | A list of Security Group ID's to allow access to. | `list(string)` | <pre>[<br>  "127.0.0.1/32"<br>]</pre> | no |
| apply\_immediately | Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false. | `bool` | `false` | no |
| redis\_failover | Specifies whether cluster should perform automatic fail-over | `bool` | `false` | no |
| redis\_maintenance\_window | Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period | `string` | `"fri:08:00-fri:09:00"` | no |
| redis\_node\_type | Instance type to use for creating the Redis cache clusters | `string` | `"cache.t2.micro"` | no |
| redis\_parameters | additional parameters modifyed in parameter group | `list(string)` | `[]` | no |
| redis\_port | Which port redis will be listening on | `number` | `6379` | no |
| redis\_snapshot\_retention\_limit | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot\_retention\_limit is not supported on cache.t1.micro or cache.t2.\* cache nodes | `number` | `0` | no |
| redis\_snapshot\_window | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period | `string` | `"06:30-07:30"` | no |
| redis\_version | Redis version to use, defaults to 3.2.10 | `string` | `"3.2.10"` | no |
| security\_groups | A list of Security Group ID's to allow access to. | `list(string)` | `[]` | no |
| tags | Tags for redis nodes | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | n/a |
| id | n/a |
| parameter\_group | n/a |
| port | n/a |
| redis\_subnet\_group\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Created by [Tim Hartmann](https://github.com/tfhartmann). Maintained by [Anton Babenko](https://github.com/antonbabenko) and [these awesome contributors](https://github.com/terraform-community-modules/tf_aws_elasticache_redis/graphs/contributors).

## License

[MIT License](LICENSE)
