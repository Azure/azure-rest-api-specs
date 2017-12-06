# Data Factory V2

> see https://aka.ms/autorest

This is the AutoRest configuration file for Data Factory V2.



---
## Getting Started
To build the SDK for Data Factory V2, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration


### Basic Information
These are the global settings for the Data Factory V2 API.

``` yaml
title: DataFactoryManagementClient
description: The Azure Data Factory V2 management API provides a RESTful set of web services that interact with Azure Data Factory V2 services.
openapi-type: arm
tag: package-2017-09-preview
```

### Tag: package-2017-09-preview

These settings apply only when `--tag=package-2017-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-09-preview'
input-file:
- Microsoft.DataFactory/2017-09-01-preview/datafactory.json
```

---
# Code Generation


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.DataFactory
  output-folder: $(csharp-sdks-folder)/DataFactory/Management.DataFactory/Generated
  clear-output-folder: true
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
  namespace: azure.mgmt.datafactory
  package-name: azure-mgmt-dafactory
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-datafactory/azure/mgmt/datafactory
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-datafactory
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: datafactory
  clear-output-folder: true
```

### Tag: package-2017-09-preview and go

These settings apply only when `--tag=package-2017-09-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-09-preview' && $(go)
output-folder: $(go-sdk-folder)/services/datafactory/mgmt/2017-09-01-preview/datafactory
```

# Validation

## Suppression

``` yaml
directive:
  - suppress: R2001  # AvoidNestedProperties
    where: 
      - $.definitions.IntegrationRuntimeResource.properties.properties
      - $.definitions.IntegrationRuntimeStatusResponse.properties.properties
      - $.definitions.TriggerResource.properties.properties
      - $.definitions.LinkedServiceResource.properties.properties
      - $.definitions.TriggerRun.properties.properties
      - $.properties.properties.LinkedServiceResource.definitions
      - $.properties.properties.LinkedServiceResource.definitions
      - $.properties.properties.IntegrationRuntimeStatusResponse.definitions
      - $.properties.properties.IntegrationRuntimeStatusResponse.definitions
      - $.properties.properties.DatasetResource.definitions
      - $.properties.properties.DatasetResource.definitions
      - $.properties.properties.TriggerResource.definitions
      - $.properties.properties.TriggerResource.definitions
    from: datafactory.json
    reason: 
      - Flattening does not work well with polymorphic models.
      - TriggerResource.properties is an arbitary dictionary and cannot be flattened.
  - suppress: R2018  # XmsEnumValidation
    where: 
      - $.definitions.Expression.properties.type
      - $.definitions.SecureString.properties.type
      - $.definitions.SecureString.properties.type
      - $.definitions.IntegrationRuntimeReference.properties.type
      - $.definitions.PipelineReference.properties.type
      - $.definitions.DatasetReference.properties.type
      - $.definitions.LinkedServiceReference.properties.type
      - $.type.properties.DatasetReference.definitions
      - $.type.properties.IntegrationRuntimeReference.definitions
      - $.type.properties.IntegrationRuntimeReference.definitions
    from: datafactory.json
    reason: Single-value enums are expressed to force the values to be used for de/serialization but should not be exposed or settable by the a client.
  - suppress: R3017  # GuidUsage
    where: 
      - $.definitions.FactoryIdentity.properties.principalId
    from: datafactory.json
    reason: 
      - FactoryIdentity.properties.principalId should be a Guid, per MSI integration.
  - suppress: R3010  # TrackedResourceListByImmediateParent
    where: 
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}"]
    from: datafactory.json
    reason:
      - Pipeline runs are listable in all but name. The operations PipelineRuns_QueryByFactory serves this purpose.
  - suppress: R1003  # ListInOperationName
    where: 
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/monitoringData"].post.operationId
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/monitoringData"].post.operationId
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/pipelineruns"].post.operationId
      - $.operationId.post["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/pipelineruns"].paths
      - $.operationId.post["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/pipelineruns"].paths
    from: datafactory.json
    reason:
      - PipelineRuns_QueryByFactory is by-design not a true list API; getting pipeline runs requires providing a filter that is part of the request body in a POST call.
```
