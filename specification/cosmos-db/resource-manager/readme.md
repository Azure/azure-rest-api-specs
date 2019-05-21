# Cosmos-DB

> see https://aka.ms/autorest

This is the AutoRest configuration file for Cosmos-DB.



---
## Getting Started
To build the SDK for Cosmos-DB, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Cosmos-DB API.

``` yaml
openapi-type: arm
tag: package-2015-04
```


### Tag: package-2015-04

These settings apply only when `--tag=package-2015-04` is specified on the command line.

``` yaml $(tag) == 'package-2015-04'
input-file:
- Microsoft.DocumentDB/stable/2015-04-08/cosmos-db.json
```

## Suppression
``` yaml
directive:
  - suppress: TrackedResourceGetOperation
    from: cosmos-db.json
    where: $.definitions.DatabaseAccountCreateUpdateParameters
    reason: The DatabaseAccount request and response resources differ so the DatabaseAccountCreateUpdateParameters must only have a PUT operation
  - suppress: TrackedResourcePatchOperation
    from: cosmos-db.json
    where: $.definitions.DatabaseAccountCreateUpdateParameters
    reason: The DatabaseAccount request and response resources differ so the DatabaseAccountCreateUpdateParameters must only have a PUT operation
  - suppress: TrackedResourcePatchOperation
    from: cosmos-db.json
    where: $.definitions.SqlDatabase
    reason: The SqlDatabase doesn't support Patch operation
  - suppress: TrackedResourcePatchOperation
    from: cosmos-db.json
    where: $.definitions.Container
    reason: The Container doesn't support Patch operation
  - suppress: TrackedResourcePatchOperation
    from: cosmos-db.json
    where: $.definitions.MongoDBDatabase
    reason: The MongoDBDatabase doesn't support Patch operation
  - suppress: TrackedResourcePatchOperation
    from: cosmos-db.json
    where: $.definitions.MongoDBCollection
    reason: The MongoDBCollection doesn't support Patch operation
  - suppress: TrackedResourcePatchOperation
    from: cosmos-db.json
    where: $.definitions.Table
    reason: The Table doesn't support Patch operation
  - suppress: TrackedResourcePatchOperation
    from: cosmos-db.json
    where: $.definitions.CassandraKeyspace
    reason: The CassandraKeyspace doesn't support Patch operation
  - suppress: TrackedResourcePatchOperation
    from: cosmos-db.json
    where: $.definitions.CassandraTable
    reason: The CassandraTable doesn't support Patch operation
  - suppress: TrackedResourcePatchOperation
    from: cosmos-db.json
    where: $.definitions.GremlinDatabase
    reason: The GremlinDatabase doesn't support Patch operation
  - suppress: TrackedResourcePatchOperation
    from: cosmos-db.json
    where: $.definitions.GremlinGraph
    reason: The GremlinGraph doesn't support Patch operation
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.MetricValue.properties._count
    reason: The Metrics API has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.ExtendedResourceProperties.properties._rid
    reason: The resource has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.ExtendedResourceProperties.properties._ts
    reason: The resource has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.ExtendedResourceProperties.properties._self
    reason: The resource has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.ExtendedResourceProperties.properties._etag
    reason: The resource has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.SqlDatabaseProperties.properties._colls
    reason: The database has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.SqlDatabaseProperties.properties._users
    reason: The database has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.GremlinDatabaseProperties.properties._rid
    reason: The resource has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.GremlinDatabaseProperties.properties._ts
    reason: The resource has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.GremlinDatabaseProperties.properties._etag
    reason: The resource has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.PercentileMetricValue.properties.P10
    reason: The Metrics API has percentile metrics property names with leading capital letters
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.PercentileMetricValue.properties.P25
    reason: The Metrics API has percentile metrics property names with leading capital letters
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.PercentileMetricValue.properties.P50
    reason: The Metrics API has percentile metrics property names with leading capital letters
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.PercentileMetricValue.properties.P75
    reason: The Metrics API has percentile metrics property names with leading capital letters
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.PercentileMetricValue.properties.P90
    reason: The Metrics API has percentile metrics property names with leading capital letters
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.PercentileMetricValue.properties.P95
    reason: The Metrics API has percentile metrics property names with leading capital letters
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.PercentileMetricValue.properties.P99
    reason: The Metrics API has percentile metrics property names with leading capital letters
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
```


## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.cosmosdb
  package-name: azure-mgmt-cosmosdb
  package-version: 0.3.0
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-cosmosdb/azure/mgmt/cosmosdb
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-cosmosdb
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)