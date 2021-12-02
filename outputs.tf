output "parameter_group" {
  value = aws_elasticache_parameter_group.redis_parameter_group.id
}

output "redis_subnet_group_name" {
  value = aws_elasticache_subnet_group.redis_subnet_group.name
}

output "id" {
  value = aws_elasticache_replication_group.redis.id
}

output "port" {
  value = var.redis_port
}

output "endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "endpoint_ro" {
  value = aws_elasticache_replication_group.redis.reader_endpoint_address
}

output "endpoint_config" {
  value = aws_elasticache_replication_group.redis.configuration_endpoint_address
}

output "cluster_enabled" {
  value = aws_elasticache_replication_group.redis.cluster_enabled
}
