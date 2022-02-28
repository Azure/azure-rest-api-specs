# OperationalInsights

> see https://aka.ms/autorest

This is the AutoRest configuration file for OperationalInsights.



---
## Getting Started
To build the SDK for OperationalInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the OperationalInsights API.

```yaml !$(python) || !$(track2)
title: OperationalInsightsManagementClient
```
```yaml $(python) && $(track2)
title: LogAnalyticsManagementClient
```

``` yaml
description: Operational Insights Client
openapi-type: arm
tag: package-2022-02
```


### Tag: package-2015-11-preview

These settings apply only when `--tag=package-2015-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-11-preview'
input-file:
- Microsoft.OperationalInsights/preview/2015-11-01-preview/LinkedServices.json
- Microsoft.OperationalInsights/preview/2015-11-01-preview/OperationalInsights.json
```

### Tag: package-2015-03

These settings apply only when `--tag=package-2015-03` is specified on the command line.

``` yaml $(tag) == 'package-2015-03'
input-file:
- Microsoft.OperationalInsights/stable/2015-03-20/OperationalInsights.json
```

### Tag: package-2019-08-preview

These settings apply only when `--tag=package-2019-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-08-preview'
input-file:
- Microsoft.OperationalInsights/preview/2019-08-01-preview/Clusters.json
- Microsoft.OperationalInsights/preview/2019-08-01-preview/LinkedServices.json
- Microsoft.OperationalInsights/preview/2019-08-01-preview/OperationalInsights.json
```

### Tag: package-2019-09-preview

These settings apply only when `--tag=package-2019-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-09-preview'
input-file:
- Microsoft.OperationalInsights/preview/2019-09-01-preview/QueryPacks_API.json
- Microsoft.OperationalInsights/preview/2019-09-01-preview/QueryPackQueries_API.json
```

### Tag: package-2020-03-preview

These settings apply only when `--tag=package-2020-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-preview'
input-file:
- Microsoft.OperationalInsights/preview/2020-03-01-preview/DataExports.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/DataSources.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/DataCollectorLogs.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/IntelligencePacks.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/LinkedServices.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/LinkedStorageAccounts.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/ManagementGroups.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/Operations.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/OperationStatuses.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/SharedKeys.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/Usages.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/Workspaces.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/Clusters.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/StorageInsightConfigs.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/SavedSearches.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/AvailableServiceTiers.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/Gateways.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/Schema.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/SharedKeys.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/WorkspacePurge.json
- Microsoft.OperationalInsights/preview/2020-03-01-preview/Tables.json
```

### Tag: package-2021-12-01-preview

These settings apply only when `--tag=package-2021-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-12-01-preview'
input-file:
- Microsoft.OperationalInsights/preview/2021-12-01-preview/Operations.json
- Microsoft.OperationalInsights/preview/2021-12-01-preview/Workspaces.json
- Microsoft.OperationalInsights/preview/2021-12-01-preview/Tables.json
- Microsoft.OperationalInsights/stable/2020-08-01/DataExports.json
- Microsoft.OperationalInsights/stable/2020-08-01/DataSources.json
- Microsoft.OperationalInsights/stable/2020-08-01/IntelligencePacks.json
- Microsoft.OperationalInsights/stable/2020-08-01/LinkedServices.json
- Microsoft.OperationalInsights/stable/2020-08-01/LinkedStorageAccounts.json
- Microsoft.OperationalInsights/stable/2020-08-01/ManagementGroups.json
- Microsoft.OperationalInsights/stable/2020-08-01/OperationStatuses.json
- Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
- Microsoft.OperationalInsights/stable/2020-08-01/Usages.json
- Microsoft.OperationalInsights/stable/2020-08-01/StorageInsightConfigs.json
- Microsoft.OperationalInsights/stable/2020-08-01/SavedSearches.json
- Microsoft.OperationalInsights/stable/2020-08-01/AvailableServiceTiers.json
- Microsoft.OperationalInsights/stable/2020-08-01/Gateways.json
- Microsoft.OperationalInsights/stable/2020-08-01/Schema.json
- Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
- Microsoft.OperationalInsights/stable/2020-08-01/WorkspacePurge.json
- Microsoft.OperationalInsights/stable/2021-06-01/Clusters.json
```

### Tag: package-2020-08

These settings apply only when `--tag=package-2020-08` is specified on the command line.

``` yaml $(tag) == 'package-2020-08'
input-file:
- Microsoft.OperationalInsights/stable/2020-08-01/DataExports.json
- Microsoft.OperationalInsights/stable/2020-08-01/DataSources.json
- Microsoft.OperationalInsights/stable/2020-08-01/IntelligencePacks.json
- Microsoft.OperationalInsights/stable/2020-08-01/LinkedServices.json
- Microsoft.OperationalInsights/stable/2020-08-01/LinkedStorageAccounts.json
- Microsoft.OperationalInsights/stable/2020-08-01/ManagementGroups.json
- Microsoft.OperationalInsights/stable/2020-08-01/Operations.json
- Microsoft.OperationalInsights/stable/2020-08-01/OperationStatuses.json
- Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
- Microsoft.OperationalInsights/stable/2020-08-01/Usages.json
- Microsoft.OperationalInsights/stable/2020-08-01/Workspaces.json
- Microsoft.OperationalInsights/stable/2020-08-01/Clusters.json
- Microsoft.OperationalInsights/stable/2020-08-01/StorageInsightConfigs.json
- Microsoft.OperationalInsights/stable/2020-08-01/SavedSearches.json
- Microsoft.OperationalInsights/stable/2020-08-01/AvailableServiceTiers.json
- Microsoft.OperationalInsights/stable/2020-08-01/Gateways.json
- Microsoft.OperationalInsights/stable/2020-08-01/Schema.json
- Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
- Microsoft.OperationalInsights/stable/2020-08-01/WorkspacePurge.json
- Microsoft.OperationalInsights/stable/2020-08-01/Tables.json
```

### Tag: package-2020-10-only
These settings apply only when `--tag=package-2020-10-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-10-only'
input-file:
- Microsoft.OperationalInsights/stable/2020-10-01/Clusters.json
- Microsoft.OperationalInsights/stable/2020-10-01/Operations.json
- Microsoft.OperationalInsights/stable/2020-10-01/Tables.json
- Microsoft.OperationalInsights/stable/2020-10-01/Workspaces.json
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10'
input-file:
- Microsoft.OperationalInsights/stable/2020-08-01/DataExports.json
- Microsoft.OperationalInsights/stable/2020-08-01/DataSources.json
- Microsoft.OperationalInsights/stable/2020-08-01/IntelligencePacks.json
- Microsoft.OperationalInsights/stable/2020-08-01/LinkedServices.json
- Microsoft.OperationalInsights/stable/2020-08-01/LinkedStorageAccounts.json
- Microsoft.OperationalInsights/stable/2020-08-01/ManagementGroups.json
- Microsoft.OperationalInsights/stable/2020-08-01/OperationStatuses.json
- Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
- Microsoft.OperationalInsights/stable/2020-08-01/Usages.json
- Microsoft.OperationalInsights/stable/2020-08-01/StorageInsightConfigs.json
- Microsoft.OperationalInsights/stable/2020-08-01/SavedSearches.json
- Microsoft.OperationalInsights/stable/2020-08-01/AvailableServiceTiers.json
- Microsoft.OperationalInsights/stable/2020-08-01/Gateways.json
- Microsoft.OperationalInsights/stable/2020-08-01/Schema.json
- Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
- Microsoft.OperationalInsights/stable/2020-08-01/WorkspacePurge.json
- Microsoft.OperationalInsights/stable/2020-08-01/Tables.json
- Microsoft.OperationalInsights/stable/2020-10-01/Clusters.json
- Microsoft.OperationalInsights/stable/2020-10-01/Operations.json
- Microsoft.OperationalInsights/stable/2020-10-01/Workspaces.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
- Microsoft.OperationalInsights/stable/2020-08-01/DataExports.json
- Microsoft.OperationalInsights/stable/2020-08-01/DataSources.json
- Microsoft.OperationalInsights/stable/2020-08-01/IntelligencePacks.json
- Microsoft.OperationalInsights/stable/2020-08-01/LinkedServices.json
- Microsoft.OperationalInsights/stable/2020-08-01/LinkedStorageAccounts.json
- Microsoft.OperationalInsights/stable/2020-08-01/ManagementGroups.json
- Microsoft.OperationalInsights/stable/2020-08-01/OperationStatuses.json
- Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
- Microsoft.OperationalInsights/stable/2020-08-01/Usages.json
- Microsoft.OperationalInsights/stable/2020-08-01/StorageInsightConfigs.json
- Microsoft.OperationalInsights/stable/2020-08-01/SavedSearches.json
- Microsoft.OperationalInsights/stable/2020-08-01/AvailableServiceTiers.json
- Microsoft.OperationalInsights/stable/2020-08-01/Gateways.json
- Microsoft.OperationalInsights/stable/2020-08-01/Schema.json
- Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
- Microsoft.OperationalInsights/stable/2020-08-01/WorkspacePurge.json
- Microsoft.OperationalInsights/stable/2021-06-01/Clusters.json
- Microsoft.OperationalInsights/stable/2020-10-01/Operations.json
- Microsoft.OperationalInsights/stable/2020-08-01/Tables.json
- Microsoft.OperationalInsights/stable/2021-06-01/Workspaces.json
```

### Tag: package-2022-02

These settings apply only when `--tag=package-2022-02` is specified on the command line.

``` yaml $(tag) == 'package-2022-02'
input-file:
- Microsoft.OperationalInsights/stable/2019-09-01/QueryPacks.json
- Microsoft.OperationalInsights/stable/2019-09-01/QueryPackQueries.json
- Microsoft.OperationalInsights/stable/2020-08-01/DataExports.json
- Microsoft.OperationalInsights/stable/2020-08-01/DataSources.json
- Microsoft.OperationalInsights/stable/2020-08-01/IntelligencePacks.json
- Microsoft.OperationalInsights/stable/2020-08-01/LinkedServices.json
- Microsoft.OperationalInsights/stable/2020-08-01/LinkedStorageAccounts.json
- Microsoft.OperationalInsights/stable/2020-08-01/ManagementGroups.json
- Microsoft.OperationalInsights/stable/2020-08-01/OperationStatuses.json
- Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
- Microsoft.OperationalInsights/stable/2020-08-01/Usages.json
- Microsoft.OperationalInsights/stable/2020-08-01/StorageInsightConfigs.json
- Microsoft.OperationalInsights/stable/2020-08-01/SavedSearches.json
- Microsoft.OperationalInsights/stable/2020-08-01/AvailableServiceTiers.json
- Microsoft.OperationalInsights/stable/2020-08-01/Gateways.json
- Microsoft.OperationalInsights/stable/2020-08-01/Schema.json
- Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
- Microsoft.OperationalInsights/stable/2020-08-01/WorkspacePurge.json
- Microsoft.OperationalInsights/stable/2021-06-01/Clusters.json
- Microsoft.OperationalInsights/preview/2021-12-01-preview/Operations.json
- Microsoft.OperationalInsights/preview/2021-12-01-preview/Workspaces.json
- Microsoft.OperationalInsights/preview/2021-12-01-preview/Tables.json
```
---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
  - repo: azure-sdk-for-java
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-powershell
```


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  # last generated using AutoRest.1.0.0-Nightly20170126
  azure-arm: true
  namespace: Microsoft.Azure.Management.OperationalInsights
  payload-flattening-threshold: 1
  license-header: MICROSOFT_MIT_NO_VERSION
  output-folder: $(csharp-sdks-folder)/operationalinsights/Microsoft.Azure.Management.OperationalInsights/src/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)


## Suppression

``` yaml
directive:
  - from: OperationalInsights.json
    suppress: R3006  # BodyTopLevelProperties/R3006/RPCViolation
    reason: properties etag defined as eTag in model
```



