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
title: CosmosDBManagementClient
openapi-type: arm
tag: package-preview-2021-11
```


### Tag: package-preview-2021-11

These settings apply only when `--tag=package-preview-2021-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-11'
input-file:
  - Microsoft.DocumentDB/preview/2021-11-15-preview/cosmos-db.json
  - Microsoft.DocumentDB/preview/2021-11-15-preview/dataTransferService.json
  - Microsoft.DocumentDB/preview/2021-11-15-preview/managedCassandra.json
  - Microsoft.DocumentDB/preview/2021-11-15-preview/mongorbac.json
  - Microsoft.DocumentDB/preview/2021-11-15-preview/notebook.json
  - Microsoft.DocumentDB/preview/2021-11-15-preview/privateEndpointConnection.json
  - Microsoft.DocumentDB/preview/2021-11-15-preview/privateLinkResources.json
  - Microsoft.DocumentDB/preview/2021-11-15-preview/rbac.json
  - Microsoft.DocumentDB/preview/2021-11-15-preview/restorable.json
  - Microsoft.DocumentDB/preview/2021-11-15-preview/services.json
```
### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

``` yaml $(tag) == 'package-2021-10'
input-file:
  - Microsoft.DocumentDB/stable/2021-10-15/cosmos-db.json
  - Microsoft.DocumentDB/stable/2021-10-15/notebook.json
  - Microsoft.DocumentDB/stable/2021-10-15/privateEndpointConnection.json
  - Microsoft.DocumentDB/stable/2021-10-15/privateLinkResources.json
  - Microsoft.DocumentDB/stable/2021-10-15/rbac.json
  - Microsoft.DocumentDB/stable/2021-10-15/restorable.json
  - Microsoft.DocumentDB/stable/2021-10-15/managedCassandra.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-preview-2021-10

These settings apply only when `--tag=package-preview-2021-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-10'
input-file:
  - Microsoft.DocumentDB/preview/2021-10-15-preview/cosmos-db.json
  - Microsoft.DocumentDB/preview/2021-10-15-preview/managedCassandra.json
  - Microsoft.DocumentDB/preview/2021-10-15-preview/notebook.json
  - Microsoft.DocumentDB/preview/2021-10-15-preview/privateEndpointConnection.json
  - Microsoft.DocumentDB/preview/2021-10-15-preview/privateLinkResources.json
  - Microsoft.DocumentDB/preview/2021-10-15-preview/rbac.json
  - Microsoft.DocumentDB/preview/2021-10-15-preview/restorable.json
  - Microsoft.DocumentDB/preview/2021-10-15-preview/services.json
  - Microsoft.DocumentDB/preview/2021-10-15-preview/mongorbac.json
  - Microsoft.DocumentDB/preview/2021-10-15-preview/dataTransferService.json
```

### Tag: package-2021-07-preview

These settings apply only when `--tag=package-2021-07-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-07-preview'
input-file:
  - Microsoft.DocumentDB/preview/2021-07-01-preview/cosmos-db.json
  - Microsoft.DocumentDB/preview/2021-07-01-preview/notebook.json
  - Microsoft.DocumentDB/preview/2021-07-01-preview/privateEndpointConnection.json
  - Microsoft.DocumentDB/preview/2021-07-01-preview/privateLinkResources.json
  - Microsoft.DocumentDB/preview/2021-07-01-preview/rbac.json
  - Microsoft.DocumentDB/preview/2021-07-01-preview/restorable.json
  - Microsoft.DocumentDB/preview/2021-07-01-preview/managedCassandra.json
  - Microsoft.DocumentDB/preview/2021-07-01-preview/services.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
  - Microsoft.DocumentDB/stable/2021-06-15/cosmos-db.json
  - Microsoft.DocumentDB/stable/2021-06-15/notebook.json
  - Microsoft.DocumentDB/stable/2021-06-15/privateEndpointConnection.json
  - Microsoft.DocumentDB/stable/2021-06-15/privateLinkResources.json
  - Microsoft.DocumentDB/stable/2021-06-15/rbac.json
  - Microsoft.DocumentDB/stable/2021-06-15/restorable.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2021-05

These settings apply only when `--tag=package-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-2021-05'
input-file:
  - Microsoft.DocumentDB/stable/2021-05-15/cosmos-db.json
  - Microsoft.DocumentDB/stable/2021-05-15/notebook.json
  - Microsoft.DocumentDB/stable/2021-05-15/rbac.json
  - Microsoft.DocumentDB/stable/2021-05-15/privateLinkResources.json
  - Microsoft.DocumentDB/stable/2021-05-15/privateEndpointConnection.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2021-04

These settings apply only when `--tag=package-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-2021-04'
input-file:
  - Microsoft.DocumentDB/stable/2021-04-15/cosmos-db.json
  - Microsoft.DocumentDB/stable/2021-04-15/notebook.json
  - Microsoft.DocumentDB/stable/2021-04-15/rbac.json
  - Microsoft.DocumentDB/stable/2021-04-15/privateLinkResources.json
  - Microsoft.DocumentDB/stable/2021-04-15/privateEndpointConnection.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2021-04-preview

These settings apply only when `--tag=package-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-2021-04-preview'
input-file:
- Microsoft.DocumentDB/preview/2021-04-01-preview/cosmos-db.json
- Microsoft.DocumentDB/preview/2021-04-01-preview/notebook.json
- Microsoft.DocumentDB/preview/2021-04-01-preview/rbac.json
- Microsoft.DocumentDB/preview/2021-04-01-preview/restorable.json
- Microsoft.DocumentDB/preview/2021-04-01-preview/managedCassandra.json
- Microsoft.DocumentDB/preview/2021-04-01-preview/privateLinkResources.json
- Microsoft.DocumentDB/preview/2021-04-01-preview/privateEndpointConnection.json
- Microsoft.DocumentDB/preview/2021-04-01-preview/services.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - Microsoft.DocumentDB/stable/2021-03-15/cosmos-db.json
  - Microsoft.DocumentDB/stable/2021-03-15/notebook.json
  - Microsoft.DocumentDB/stable/2021-03-15/privateLinkResources.json
  - Microsoft.DocumentDB/stable/2021-03-15/privateEndpointConnection.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2021-03-preview

These settings apply only when `--tag=package-2021-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-03-preview'
input-file:
  - Microsoft.DocumentDB/preview/2021-03-01-preview/cosmos-db.json
  - Microsoft.DocumentDB/preview/2021-03-01-preview/notebook.json
  - Microsoft.DocumentDB/preview/2021-03-01-preview/rbac.json
  - Microsoft.DocumentDB/preview/2021-03-01-preview/restorable.json
  - Microsoft.DocumentDB/preview/2021-03-01-preview/managedCassandra.json
  - Microsoft.DocumentDB/preview/2021-03-01-preview/privateLinkResources.json
  - Microsoft.DocumentDB/preview/2021-03-01-preview/privateEndpointConnection.json
modelerfour:
  lenient-model-deduplication: true
tag: package-preview-2021-04
```

### Tag: package-preview-2021-04

These settings apply only when `--tag=package-preview-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-04'
input-file:
  - Microsoft.DocumentDB/preview/2021-04-01-preview/cosmos-db.json
  - Microsoft.DocumentDB/preview/2021-04-01-preview/managedCassandra.json
  - Microsoft.DocumentDB/preview/2021-04-01-preview/notebook.json
  - Microsoft.DocumentDB/preview/2021-04-01-preview/privateEndpointConnection.json
  - Microsoft.DocumentDB/preview/2021-04-01-preview/privateLinkResources.json
  - Microsoft.DocumentDB/preview/2021-04-01-preview/rbac.json
  - Microsoft.DocumentDB/preview/2021-04-01-preview/restorable.json
```

### Tag: package-2021-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01'
input-file:
  - Microsoft.DocumentDB/stable/2021-01-15/cosmos-db.json
  - Microsoft.DocumentDB/stable/2021-01-15/notebook.json
  - Microsoft.DocumentDB/stable/2021-01-15/privateLinkResources.json
  - Microsoft.DocumentDB/stable/2021-01-15/privateEndpointConnection.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2020-09

These settings apply only when `--tag=package-2020-09` is specified on the command line.

``` yaml $(tag) == 'package-2020-09'
input-file:
  - Microsoft.DocumentDB/stable/2020-09-01/cosmos-db.json
  - Microsoft.DocumentDB/stable/2020-09-01/notebook.json
  - Microsoft.DocumentDB/preview/2019-08-01-preview/privateLinkResources.json
  - Microsoft.DocumentDB/preview/2019-08-01-preview/privateEndpointConnection.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2020-06-preview

These settings apply only when `--tag=package-2020-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-preview'
input-file:
- Microsoft.DocumentDB/preview/2020-06-01-preview/cosmos-db.json
- Microsoft.DocumentDB/preview/2020-06-01-preview/notebook.json
- Microsoft.DocumentDB/preview/2020-06-01-preview/rbac.json
- Microsoft.DocumentDB/preview/2020-06-01-preview/restorable.json
- Microsoft.DocumentDB/preview/2019-08-01-preview/privateLinkResources.json
- Microsoft.DocumentDB/preview/2019-08-01-preview/privateEndpointConnection.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2020-04

These settings apply only when `--tag=package-2020-04` is specified on the command line.

``` yaml $(tag) == 'package-2020-04'
input-file:
- Microsoft.DocumentDB/stable/2020-04-01/cosmos-db.json
- Microsoft.DocumentDB/stable/2020-04-01/notebook.json
- Microsoft.DocumentDB/preview/2019-08-01-preview/privateLinkResources.json
- Microsoft.DocumentDB/preview/2019-08-01-preview/privateEndpointConnection.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2020-03

These settings apply only when `--tag=package-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-2020-03'
input-file:
- Microsoft.DocumentDB/stable/2020-03-01/cosmos-db.json
- Microsoft.DocumentDB/stable/2020-03-01/notebook.json
- Microsoft.DocumentDB/preview/2019-08-01-preview/privateLinkResources.json
- Microsoft.DocumentDB/preview/2019-08-01-preview/privateEndpointConnection.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2019-12

These settings apply only when `--tag=package-2019-12` is specified on the command line.

``` yaml $(tag) == 'package-2019-12'
input-file:
- Microsoft.DocumentDB/stable/2019-12-12/cosmos-db.json
- Microsoft.DocumentDB/stable/2019-12-12/notebook.json
- Microsoft.DocumentDB/preview/2019-08-01-preview/privateLinkResources.json
- Microsoft.DocumentDB/preview/2019-08-01-preview/privateEndpointConnection.json
```

### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` is specified on the command line.

``` yaml $(tag) == 'package-2019-08'
input-file:
- Microsoft.DocumentDB/stable/2019-08-01/cosmos-db.json
- Microsoft.DocumentDB/stable/2019-08-01/notebook.json
```

### Tag: package-2019-08-preview

These settings apply only when `--tag=package-2019-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-08-preview'
input-file:
- Microsoft.DocumentDB/stable/2019-08-01/cosmos-db.json
- Microsoft.DocumentDB/stable/2019-08-01/notebook.json
- Microsoft.DocumentDB/preview/2019-08-01-preview/privateLinkResources.json
- Microsoft.DocumentDB/preview/2019-08-01-preview/privateEndpointConnection.json
```

### Tag: package-2015-04

These settings apply only when `--tag=package-2015-04` is specified on the command line.

``` yaml $(tag) == 'package-2015-04'
input-file:
- Microsoft.DocumentDB/stable/2015-04-08/cosmos-db.json
```

### Tag: package-2014-04

These settings apply only when `--tag=package-2014-04` is specified on the command line.

``` yaml $(tag) == 'package-2014-04'
input-file:
- Microsoft.DocumentDB/stable/2014-04-01/cosmos-db.json
```

### Tag: package-2015-11

These settings apply only when `--tag=package-2015-11` is specified on the command line.

``` yaml $(tag) == 'package-2015-11'
input-file:
- Microsoft.DocumentDB/stable/2015-11-06/cosmos-db.json
```

### Tag: package-2016-03-19

These settings apply only when `--tag=package-2016-03-19` is specified on the command line.

``` yaml $(tag) == 'package-2016-03-19'
input-file:
- Microsoft.DocumentDB/stable/2016-03-19/cosmos-db.json
```

### Tag: package-2016-03-31

These settings apply only when `--tag=package-2016-03-31` is specified on the command line.

``` yaml $(tag) == 'package-2016-03-31'
input-file:
- Microsoft.DocumentDB/stable/2016-03-31/cosmos-db.json
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
    where: $.definitions.ExtendedResourceProperties.properties._etag
    reason: The resource has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.SqlDatabaseGetProperties.properties._colls
    reason: The database has a property name with a leading underscore character
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: cosmos-db.json
    where: $.definitions.SqlDatabaseGetProperties.properties._users
    reason: The database has a property name with a leading underscore character
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
  - suppress: PathResourceProviderNamePascalCase
    from: cosmos-db.json
    reason: The name of the provider is Microsoft.DocumentDB
  - suppress: PathResourceProviderNamePascalCase
    from: notebook.json
    reason: The name of the provider is Microsoft.DocumentDB
  - suppress: PathResourceProviderNamePascalCase
    from: managedCassandra.json
    reason: The name of the provider is Microsoft.DocumentDB
  - suppress: PathResourceProviderNamePascalCase
    from: privateEndpointConnection.json
    reason: The name of the provider is Microsoft.DocumentDB
  - suppress: PathResourceProviderNamePascalCase
    from: privateLinkResources.json
    reason: The name of the provider is Microsoft.DocumentDB
  - suppress: PathResourceProviderNamePascalCase
    from: rbac.json
    reason: The name of the provider is Microsoft.DocumentDB
  - suppress: RequiredReadOnlySystemData
    reason: We do not yet support system data
  - suppress: ListInOperationName
    from: managedCassandra.json
    reason: False positive on GET instanceView.
  - suppress: RequiredDefaultResponse
    from: cosmos-db.json
    reason: Linter rules added without correcting existing issues.
  - suppress: DeleteOperationResponses
    from: managedCassandra.json
    reason: Linter is broken and throwing false positives.
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-resource-manager-schemas
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.CosmosDB
  output-folder: $(csharp-sdks-folder)/cosmosdb/Microsoft.Azure.Management.CosmosDB/src/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
