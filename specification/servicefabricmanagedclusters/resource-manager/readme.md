# Service Fabric Managed Clusters REST APIs

> see https://aka.ms/autorest

This is the AutoRest configuration file for Service Fabric Managed Clusters.

Azure Service Fabric Managed Clusters are an evolution of the Azure Service Fabric cluster resource model where all the underlying resources for the cluster are abstracted away and managed by Azure on your behalf.

[Azure Service Fabric](http://aka.ms/ServiceFabric) is a distributed systems platform that makes it easy to package, deploy, and manage scalable and reliable microservices.

---
## Getting Started
To build the SDK for ServiceFabricManagedClustersManagementClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

These are the global settings for the ServiceFabricManagedClustersManagementClient API.

``` yaml
title: ServiceFabricManagedClustersManagementClient
description: Service Fabric Managed Clusters Management Client
openapi-type: arm
tag: package-2022-01

directive:
  - suppress: ListInOperationName
    reason: Modifying the operation names would break the backwards compatibility of the API.
  - suppress: LongRunningResponseStatusCode
    reason: The validation tools do not properly recognize 202 as a supported response code.
  - suppress: SummaryAndDescriptionMustNotBeSame
    reason: There are a lot of APIs with missing summary content. While it is being worked on disabling this to ensure that we catch and fix other violations.
  - suppress: TrackedResourceListByImmediateParent
    reason: Proxy resources are not properly evaluated by the validation toolset.
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Modifying the operation names would break the backwards compatibility of the API.
  - suppress: EnumInsteadOfBoolean
    reason: The boolean properties are actually boolean value in the Service Fabric's application model.
  - suppress: TrackedResourceGetOperation
    reason: Proxy resources are not properly evaluated by the validation toolset.
  - suppress: TrackedResourcePatchOperation
    reason: Proxy resources are not properly evaluated by the validation toolset.
  - suppress: TrackedResourceListByResourceGroup
    reason: Proxy resources are not properly evaluated by the validation toolset.
  - suppress: TrackedResourceListBySubscription
    reason: Proxy resources are not properly evaluated by the validation toolset.
  - suppress: DescriptionAndTitleMissing
    reason: There are a lot of APIs with missing titles. While it is being worked on disabling this to ensure that we catch and fix other violations.
  - suppress: Example Validations
    reason: There are open issues (bugs) in the validator affecting some of the examples and since there is no way to selectively disable the validation for a particular example or paths, all of the example validation is being turned off.
  - suppress: Example Validations
    reason: There are open issues (bugs) in the validator affecting some of the examples and since there is no way to selectively disable the validation for a particular example or paths, all of the example validation is being turned off.
  - suppress: R3006
    where:
      - $.definitions.ManagedCluster.properties
      - $.definitions.NodeType.properties
      - $.definitions.ApplicationTypeResource.properties
      - $.definitions.ApplicationTypeVersionResource.properties
      - $.definitions.ApplicationResource.properties
      - $.definitions.ServiceResource.properties
    reason:
      - Currently systemData is not allowed.

```

### Tag: package-2022-01

These settings apply only when `--tag=package-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-01'
input-file:
- Microsoft.ServiceFabric/stable/2022-01-01/managedapplication.json
- Microsoft.ServiceFabric/stable/2022-01-01/managedcluster.json
- Microsoft.ServiceFabric/stable/2022-01-01/nodetype.json
```

### Tag: package-2021-11-preview

These settings apply only when `--tag=package-2021-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-11-preview'
input-file:
- Microsoft.ServiceFabric/preview/2021-11-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2021-11-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2021-11-01-preview/nodetype.json
```

### Tag: package-2021-09-privatepreview

These settings apply only when `--tag=package-2021-09-privatepreview` is specified on the command line.

``` yaml $(tag) == 'package-2021-09-privatepreview'
input-file:
- Microsoft.ServiceFabric/preview/2021-09-01-privatepreview/managedapplication.json
- Microsoft.ServiceFabric/preview/2021-09-01-privatepreview/managedcluster.json
- Microsoft.ServiceFabric/preview/2021-09-01-privatepreview/nodetype.json
```

### Tag: package-2021-07-preview

These settings apply only when `--tag=package-2021-07-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-07-preview'
input-file:
- Microsoft.ServiceFabric/preview/2021-07-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2021-07-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2021-07-01-preview/nodetype.json
```

### Tag: package-2021-05

These settings apply only when `--tag=package-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-2021-05'
input-file:
- Microsoft.ServiceFabric/stable/2021-05-01/managedapplication.json
- Microsoft.ServiceFabric/stable/2021-05-01/managedcluster.json
- Microsoft.ServiceFabric/stable/2021-05-01/nodetype.json
```

### Tag: package-2021-01-preview

These settings apply only when `--tag=package-2021-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-preview'
input-file:
- Microsoft.ServiceFabric/preview/2021-01-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2021-01-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2021-01-01-preview/nodetype.json
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-resource-manager-schemas
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.ServiceFabricManagedClusters
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/servicefabricmanagedclusters/Microsoft.Azure.Management.ServiceFabricManagedClusters/src/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)



