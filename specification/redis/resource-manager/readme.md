# Redis
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Redis.



---
## Getting Started 
To build the SDK for Redis, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Redis API.

``` yaml
openapi-type: arm
tag: package-2017-10
```

### Tag: package-2017-10

These settings apply only when `--tag=package-2017-10` is specified on the command line.

``` yaml $(tag) == 'package-2017-10'
input-file:
- Microsoft.Cache/2017-10-01/redis.json
```


### Tag: package-2017-02

These settings apply only when `--tag=package-2017-02` is specified on the command line.

``` yaml $(tag) == 'package-2017-02'
input-file:
- Microsoft.Cache/2017-02-01/redis.json
```


### Tag: package-2016-04

These settings apply only when `--tag=package-2016-04` is specified on the command line.

``` yaml $(tag) == 'package-2016-04'
input-file:
- Microsoft.Cache/2016-04-01/redis.json
```
 
### Tag: package-2015-08

These settings apply only when `--tag=package-2015-08` is specified on the command line.

``` yaml $(tag) == 'package-2015-08'
input-file:
- Microsoft.Cache/2015-08-01/redis.json
```


---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated with AutoRest.0.17.3
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Redis
  output-folder: $(csharp-sdks-folder)/RedisCache/Management.Redis/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: redis
  clear-output-folder: true
```

### Tag: package-2017-10 and go

These settings apply only when `--tag=package-2017-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-10' && $(go)
output-folder: $(go-sdk-folder)/services/redis/mgmt/2017-10-01/cache
```


### Tag: package-2017-02 and go

These settings apply only when `--tag=package-2017-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-02' && $(go)
output-folder: $(go-sdk-folder)/services/redis/mgmt/2017-02-01/redis
```

### Tag: package-2016-04 and go

These settings apply only when `--tag=package-2016-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-04' && $(go)
output-folder: $(go-sdk-folder)/services/redis/mgmt/2016-04-01/redis
```

### Tag: package-2015-08 and go

These settings apply only when `--tag=package-2015-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-08' && $(go)
output-folder: $(go-sdk-folder)/services/redis/mgmt/2015-08-01/redis
```

# Validation

## Suppression

``` yaml
directive:
  - suppress: R3006  # Model definition 'RedisResource' has extra properties ['zones']."
    where:
      - $.definitions.RedisResource.properties
    from: redis.json
    reason: zones properties will be allowed in subsequent version of the linter tool
```