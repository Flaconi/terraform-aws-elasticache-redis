resource "random_id" "salt" {
  byte_length = 8
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id       = format("%.20s", "${var.name}-${var.env}")
  description                = "Terraform-managed ElastiCache replication group for ${var.name}-${var.env}-${data.aws_vpc.vpc.tags["Name"]}"
  num_cache_clusters         = var.redis_clusters
  node_type                  = var.redis_node_type
  automatic_failover_enabled = var.redis_clusters > 1 ? var.redis_failover : false
  multi_az_enabled           = (var.redis_failover && var.redis_clusters > 1) ? var.multi_az_enabled : false
  engine_version             = var.redis_version
  port                       = var.redis_port
  parameter_group_name       = aws_elasticache_parameter_group.redis_parameter_group.id
  subnet_group_name          = aws_elasticache_subnet_group.redis_subnet_group.id
  security_group_ids         = var.security_groups
  apply_immediately          = var.apply_immediately
  maintenance_window         = var.redis_maintenance_window
  snapshot_window            = var.redis_snapshot_window
  snapshot_retention_limit   = var.redis_snapshot_retention_limit
  tags = merge(
    {
      "Name" = format(
        "tf-elasticache-%s-%s",
        var.name,
        lookup(data.aws_vpc.vpc.tags, "Name", ""),
      )
    },
    var.tags,
  )
}

resource "aws_elasticache_parameter_group" "redis_parameter_group" {
  name = replace(
    format(
      "%.255s",
      lower(
        replace(
          "tf-redis-${var.name}-${var.env}-${data.aws_vpc.vpc.tags["Name"]}-${replace(var.redis_version, ".", "-")}-${random_id.salt.hex}",
          "_",
          "-",
        ),
      ),
    ),
    "/\\s/",
    "-",
  )

  description = "Terraform-managed ElastiCache parameter group for ${var.name}-${var.env}-${data.aws_vpc.vpc.tags["Name"]}-${replace(var.redis_version, ".", "-")}"

  # Strip the patch version from redis_version var
  family = "redis${replace(var.redis_version, "/\\.[\\d]+$/", "")}"
  dynamic "parameter" {
    for_each = var.redis_parameters
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name = replace(
    format(
      "%.255s",
      lower(
        replace(
          "tf-redis-${var.name}-${var.env}-${data.aws_vpc.vpc.tags["Name"]}",
          "_",
          "-",
        ),
      ),
    ),
    "/\\s/",
    "-",
  )
  subnet_ids = var.subnets
}
