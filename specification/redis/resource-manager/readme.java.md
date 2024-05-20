## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
directive:
  - from: redis.json
    where: $.definitions.RedisCommonProperties.properties.redisConfiguration.additionalProperties
    transform: $['type'] = "string"
    reason: additonal properties should be string to string map
```