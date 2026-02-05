## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/redis/armredis/v3
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
- rename-model:
   from: 'RedisResource'
   to: 'ResourceInfo'
- from: swagger-document
  where: $.definitions.RedisCreateProperties
  transform: >
    $["x-ms-external"] = false
- from: swagger-document
  where: $.definitions.RedisUpdateProperties
  transform: >
    $["x-ms-external"] = false
- from: swagger-document
  where: $.definitions.RedisProperties
  transform: >
    $["x-ms-external"] = false
- from: swagger-document
  where: $.definitions.OperationStatus
  transform: >
    $["x-ms-external"] = false
```
