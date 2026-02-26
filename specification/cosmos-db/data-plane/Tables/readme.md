# Table Dataplane

> see https://aka.ms/autorest

This is the AutoRest configuration file for Tables.



---
## Getting Started
To build the SDK for Tables, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Tables API.

``` yaml
azure-validator: true
openapi-type: data-plane
tag: package-2019-02
```

### Tag: package-2019-02

These settings apply only when `--tag=package-2019-02` is specified on the command line.

``` yaml $(tag) == 'package-2019-02'
input-file:
- stable/2019-02-02/table.json
```

---
# Suppressions

``` yaml
directive:
  - suppress: D5001
    where: $["x-ms-paths"]["/?ServiceProperties"].put
    reason: The path only supports XML input/outputm which is not supported
  - suppress: D5001
    where: $["x-ms-paths"]["/?ServiceProperties"].get
    reason: The path only supports XML input/outputm which is not supported
  - suppress: D5001
    where: $["x-ms-paths"]["/?ServiceStats"].get
    reason: The path only supports XML input/outputm which is not supported
  - suppress: D5001
    where: $.paths["/{table}"].get
    reason: The path only supports XML input/outputm which is not supported
  - suppress: D5001
    where: $.paths["/{table}"].put
    reason: The path only supports XML input/outputm which is not supported
  - suppress: R3016
    where: $.definitions.TableServiceError.properties.Message
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableServiceProperties.properties.Logging
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableServiceProperties.properties.HourMetrics
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableServiceProperties.properties.MinuteMetrics
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableServiceProperties.properties.Cors
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.Logging.properties.Version
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.Logging.properties.Delete
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.Logging.properties.Read
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.Logging.properties.Write
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.Logging.properties.RetentionPolicy
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.Metrics.properties.Version
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.Metrics.properties.Enabled
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.Metrics.properties.IncludeAPIs
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.Metrics.properties.RetentionPolicy
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.CorsRule.properties.AllowedOrigins
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.CorsRule.properties.AllowedMethods
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.CorsRule.properties.AllowedHeaders
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.CorsRule.properties.ExposedHeaders
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.CorsRule.properties.MaxAgeInSeconds
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.RetentionPolicy.properties.Enabled
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.RetentionPolicy.properties.Days
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableServiceStats.properties.GeoReplication
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.GeoReplication.properties.Status
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.GeoReplication.properties.LastSyncTime
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableProperties.properties.TableName
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableResponse.properties["odata.metadata"]
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableQueryResponse.properties["odata.metadata"]
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableResponseProperties.properties.TableName
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableResponseProperties.properties["odata.type"]
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableResponseProperties.properties["odata.id"]
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableResponseProperties.properties["odata.editLink"]
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.SignedIdentifier.properties.Id
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.SignedIdentifier.properties.AccessPolicy
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.AccessPolicy.properties.Start
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.AccessPolicy.properties.Expiry
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.AccessPolicy.properties.Permission
    reason: Response from service is not camel case
  - suppress: R3016
    where: $.definitions.TableEntityQueryResponse.properties["odata.metadata"]
    reason: Response from service is not camel case
  - suppress: R2058
    where: $["x-ms-paths"]["/?ServiceStats"]
    reason: Cannot provide operation in "paths"
  - suppress: R2058
    where: $["x-ms-paths"]["/?ServiceProperties"]
    reason: Cannot provide operation in "paths"
```
