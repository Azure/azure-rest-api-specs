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

``` yaml
title: OperationalInsightsManagementClient
description: Operational Insights Client
openapi-type: arm
tag: package-2020-08
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

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10'
input-file:
- Microsoft.OperationalInsights/stable/2020-10-01/Clusters.json
- Microsoft.OperationalInsights/stable/2020-10-01/Operations.json
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

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
  - repo: azure-sdk-for-java
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_operational_insights']
  - repo: azure-resource-manager-schemas
    after_scripts:
      - node sdkauto_afterscript.js operationalinsights/resource-manager
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

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && !$(track2)
directive:
    - from: swagger-document
      where: $.info
      transform: >
          $.title = 'LogAnalyticsManagementClient';
          $.description = 'The Log Analytics Client.';
          return $;
         
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.loganalytics
  package-name: azure-mgmt-loganalytics
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update' && !$(track2)
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/loganalytics/azure-mgmt-loganalytics/azure/mgmt/loganalytics
```
``` yaml $(python) && $(python-mode) == 'create'  && !$(track2)
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/loganalytics/azure-mgmt-loganalytics
```

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

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)

