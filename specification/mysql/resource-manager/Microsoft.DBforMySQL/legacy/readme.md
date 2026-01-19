# MySql

> see https://aka.ms/autorest

This is the AutoRest configuration file for MySql.

---

## Getting Started

To build the SDK for MySql, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the MySql API.

``` yaml
tag: package-2020-01-01
```

### Tag: package-2017-12-01-preview

These settings apply only when `--tag=package-2017-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-12-01-preview'
input-file:
- preview/2017-12-01-preview/mysql.json
```

### Tag: package-2017-12-01

These settings apply only when `--tag=package-2017-12-01` is specified on the command line.

``` yaml $(tag) == 'package-2017-12-01'
input-file:
- stable/2017-12-01/mysql.json
- stable/2017-12-01/ServerSecurityAlertPolicies.json
```

### Tag: package-2018-06-01-privatepreview

These settings apply only when `--tag=package-2018-06-01-privatepreview` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-01-privatepreview'
input-file:
- preview/2018-06-01-privatepreview/mysql.json
- preview/2018-06-01-privatepreview/PrivateEndpointConnections.json
- preview/2018-06-01-privatepreview/PrivateLinkResources.json
```

### Tag: package-2018-06-01

These settings apply only when `--tag=package-2018-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-01'
input-file:
- stable/2017-12-01/mysql.json
- stable/2017-12-01/ServerSecurityAlertPolicies.json
- stable/2018-06-01/QueryPerformanceInsights.json
- stable/2018-06-01/PerformanceRecommendations.json
- stable/2018-06-01/PrivateEndpointConnections.json
- stable/2018-06-01/PrivateLinkResources.json
```

### Tag: package-2020-01-01-privatepreview

These settings apply only when `--tag=package-2020-01-01-privatepreview` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-01-privatepreview'
input-file:
- preview/2020-01-01-privatepreview/DataEncryptionKeys.json
```

### Tag: package-2020-01-01

These settings apply only when `--tag=package-2020-01-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-01'
input-file:
- stable/2017-12-01/mysql.json
- stable/2017-12-01/ServerSecurityAlertPolicies.json
- stable/2018-06-01/QueryPerformanceInsights.json
- stable/2018-06-01/PerformanceRecommendations.json
- stable/2018-06-01/PrivateEndpointConnections.json
- stable/2018-06-01/PrivateLinkResources.json
- stable/2020-01-01/DataEncryptionKeys.json
- stable/2020-01-01/Servers.json
```

## Suppression

``` yaml
directive:
  - suppress: PathResourceProviderNamePascalCase
    reason: The name of the provider is Microsoft.DBforMySQL
  - suppress: OperationsApiResponseSchema
    from: mysql.json
    reason: Property isDataAction is not included in get operation reponse body
  - suppress: OperationsApiResponseSchema
    from: Microsoft.DBforMySQL/preview/2021-12-01-preview/ServiceOperations.json
    reason: Property isDataAction is not included in get operation reponse body
```