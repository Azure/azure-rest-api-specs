# PostgreSQL

> see https://aka.ms/autorest

This is the AutoRest configuration file for Sql.



---
## Getting Started
To build the SDK for PostgreSQL, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the PostgreSQL API.

``` yaml
title: PostgreSQLManagementClient
description: The Microsoft Azure management API provides create, read, update, and delete functionality for Azure PostgreSQL resources including servers, databases, firewall rules, VNET rules, security alert policies, log files and configurations with new business model.
openapi-type: arm
tag: package-flexibleserver-2021-06
```

``` yaml $(package-flexibleservers)
tag: package-flexibleserver-2021-06
```

``` yaml $(package-singleservers)
tag: package-2020-01-01
```

### Tag: package-2021-06-15-privatepreview

These settings apply only when `--tag=package-2021-06-15-privatepreview` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-15-privatepreview'
input-file:
- Microsoft.DBforPostgreSQL/preview/2021-06-15-privatepreview/Migrations.json
- Microsoft.DBforPostgreSQL/preview/2021-06-15-privatepreview/postgresql.json
```

### Tag: package-flexibleserver-2021-06

These settings apply only when `--tag=package-flexibleserver-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2021-06'
input-file:
- Microsoft.DBforPostgreSQL/stable/2021-06-01/postgresql.json
- Microsoft.DBforPostgreSQL/stable/2021-06-01/Databases.json
- Microsoft.DBforPostgreSQL/stable/2021-06-01/PrivateDnsZone.json
```

### Tag: package-flexibleserver-2021-06-preview

These settings apply only when `--tag=package-flexibleserver-2021-06-preview` is specified on the command line.cd ..

``` yaml $(tag) == 'package-flexibleserver-2021-06-preview'
input-file:
- Microsoft.DBforPostgreSQL/preview/2021-06-01-preview/postgresql.json
- Microsoft.DBforPostgreSQL/preview/2020-11-05-preview/Databases.json
- Microsoft.DBforPostgreSQL/preview/2021-03-31-privatepreview/PrivateDnsZone.json
- Microsoft.DBforPostgreSQL/preview/2021-06-01-preview/IntelligentPerformance.json
- Microsoft.DBforPostgreSQL/preview/2021-06-01-preview/QueryPerformanceInsights.json
```

### Tag: package-2021-04-10-privatepreview

These settings apply only when `--tag=package-2021-04-10-privatepreview` is specified on the command line.

``` yaml $(tag) == 'package-2021-04-10-privatepreview'
input-file:
- Microsoft.DBforPostgreSQL/preview/2020-11-05-preview/Databases.json
- Microsoft.DBforPostgreSQL/preview/2021-03-31-privatepreview/PrivateDnsZone.json
- Microsoft.DBforPostgreSQL/preview/2021-04-10-privatepreview/postgresql.json
```


### Tag: package-2021-03-31-privatepreview

These settings apply only when `--tag=package-2021-03-31-privatepreview` is specified on the command line.

``` yaml $(tag) == 'package-2021-03-31-privatepreview'
input-file:
- Microsoft.DBforPostgreSQL/preview/2020-02-14-preview/postgresql.json
- Microsoft.DBforPostgreSQL/preview/2020-11-05-preview/Databases.json
- Microsoft.DBforPostgreSQL/preview/2021-03-31-privatepreview/PrivateDnsZone.json
```


### Tag: package-2020-11-05-preview

These settings apply only when `--tag=package-2020-11-05-preview` is specified on the command line.


``` yaml $(tag) == 'package-2020-11-05-preview'
input-file:
- Microsoft.DBforPostgreSQL/preview/2020-02-14-preview/postgresql.json
- Microsoft.DBforPostgreSQL/preview/2020-11-05-preview/Databases.json
```


### Tag: package-2020-02-14-preview

These settings apply only when `--tag=package-2020-02-14-preview` is specified on the command line.


``` yaml $(tag) == 'package-2020-02-14-preview'
input-file:
- Microsoft.DBforPostgreSQL/preview/2020-02-14-preview/postgresql.json
```


### Tag: package-2020-02-14-privatepreview

These settings apply only when `--tag=package-2020-02-14-privatepreview` is specified on the command line.


``` yaml $(tag) == 'package-2020-02-14-privatepreview'
input-file:
- Microsoft.DBforPostgreSQL/preview/2020-02-14-privatepreview/postgresql.json
```

### Tag: package-2020-01-01-privatepreview

These settings apply only when `--tag=package-2020-01-01-privatepreview` is specified on the command line.


``` yaml $(tag) == 'package-2020-01-01-privatepreview'
input-file:
- Microsoft.DBforPostgreSQL/preview/2020-01-01-privatepreview/DataEncryptionKeys.json
```


### Tag: package-2020-01-01

These settings apply only when `--tag=package-2020-01-01` is specified on the command line.


``` yaml $(tag) == 'package-2020-01-01'
input-file:
- Microsoft.DBforPostgreSQL/stable/2017-12-01/postgresql.json
- Microsoft.DBforPostgreSQL/stable/2017-12-01/ServerSecurityAlertPolicies.json
- Microsoft.DBforPostgreSQL/stable/2018-06-01/PrivateEndpointConnections.json
- Microsoft.DBforPostgreSQL/stable/2018-06-01/PrivateLinkResources.json
- Microsoft.DBforPostgreSQL/stable/2020-01-01/DataEncryptionKeys.json
```


### Tag: package-2018-06-01-privatepreview

These settings apply only when `--tag=package-2018-06-01-privatepreview` is specified on the command line.


``` yaml $(tag) == 'package-2018-06-01-privatepreview'
input-file:
- Microsoft.DBforPostgreSQL/preview/2018-06-01-privatepreview/PrivateEndpointConnections.json
- Microsoft.DBforPostgreSQL/preview/2018-06-01-privatepreview/PrivateLinkResources.json
```

### Tag: package-2018-06-01

These settings apply only when `--tag=package-2018-06-01` is specified on the command line.


``` yaml $(tag) == 'package-2018-06-01'
input-file:
- Microsoft.DBforPostgreSQL/stable/2017-12-01/postgresql.json
- Microsoft.DBforPostgreSQL/stable/2017-12-01/ServerSecurityAlertPolicies.json
- Microsoft.DBforPostgreSQL/stable/2018-06-01/PrivateEndpointConnections.json
- Microsoft.DBforPostgreSQL/stable/2018-06-01/PrivateLinkResources.json
- Microsoft.DBforPostgreSQL/stable/2018-06-01/QueryPerformanceInsights.json
- Microsoft.DBforPostgreSQL/stable/2018-06-01/PerformanceRecommendations.json

```


### Tag: package-2017-12-01-preview

These settings apply only when `--tag=package-2017-12-01-preview` is specified on the command line.


``` yaml $(tag) == 'package-2017-12-01-preview'
input-file:
- Microsoft.DBforPostgreSQL/preview/2017-12-01-preview/postgresql.json
```


### Tag: package-2017-12-01

These settings apply only when `--tag=package-2017-12-01` is specified on the command line.


``` yaml $(tag) == 'package-2017-12-01'
input-file:
- Microsoft.DBforPostgreSQL/stable/2017-12-01/postgresql.json
- Microsoft.DBforPostgreSQL/stable/2017-12-01/ServerSecurityAlertPolicies.json
```

## Suppression
``` yaml
directive:
  - suppress: PathResourceProviderNamePascalCase
    reason: The name of the provider is DBforPostgreSQL
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

### C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.PostgreSQL
  output-folder: $(csharp-sdks-folder)/postgresql/Microsoft.Azure.Management.PostgreSQL/src/postgresql/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)



