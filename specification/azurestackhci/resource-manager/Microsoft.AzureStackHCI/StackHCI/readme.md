# azurestackhci

> see https://aka.ms/autorest

This is the AutoRest configuration file for azurestackhci.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the azurestackhci.

``` yaml
title: AzureStackHCIClient
description: Azure Stack HCI management service
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-04

directive:
  - from: edgeDevices.json
    where: $.definitions
    transform: >
      $.ErrorDetail['x-ms-client-name'] = 'HciValidationFailureDetail';
      $.Extension['x-ms-client-name'] = 'HciEdgeDeviceArcExtension';
      $.Intents['x-ms-client-name'] = 'HciEdgeDeviceIntents';
      $.HostNetwork['x-ms-client-name'] = 'HciEdgeDeviceHostNetwork';
      $.StorageNetworks['x-ms-client-name'] = 'HciEdgeDeviceStorageNetworks';
      $.StorageAdapterIPInfo['x-ms-client-name'] = 'HciEdgeDeviceStorageAdapterIPInfo';
      $.AdapterPropertyOverrides['x-ms-client-name'] = 'HciEdgeDeviceAdapterPropertyOverrides';
      $.VirtualSwitchConfigurationOverrides['x-ms-client-name'] = 'HciEdgeDeviceVirtualSwitchConfigurationOverrides';
  - from: deploymentSettings.json
    where: $.definitions
    transform: >
      $.Intents['x-ms-client-name'] = 'DeploymentSettingIntents';
      $.HostNetwork['x-ms-client-name'] = 'DeploymentSettingHostNetwork';
      $.StorageNetworks['x-ms-client-name'] = 'DeploymentSettingStorageNetworks';
      $.StorageAdapterIPInfo['x-ms-client-name'] = 'DeploymentSettingStorageAdapterIPInfo';
      $.AdapterPropertyOverrides['x-ms-client-name'] = 'DeploymentSettingAdapterPropertyOverrides';
      $.VirtualSwitchConfigurationOverrides['x-ms-client-name'] = 'DeploymentSettingVirtualSwitchConfigurationOverrides';
  - from: swagger-document
    where: 
      - $.definitions.Extension.allOf[0]
      - $.definitions.Offer.allOf[0]
      - $.definitions.Publisher.allOf[0]
      - $.definitions.Sku.allOf[0]
      - $.definitions.UpdateRun.allOf[0]
      - $.definitions.Update.allOf[0]
      - $.definitions.UpdateSummaries.allOf[0]
    transform: >
      $['$ref'] = "../../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"
  - from: swagger-document
    where: $.paths[*]..responses.default
    transform: $.schema['$ref'] = "../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse"
```

## Suppression

``` yaml
directive:
  - suppress: R3020
    from:
      - arcSettings.json
      - clusters.json
      - extensions.json
      - operations.json
      - offers.json
      - publishers.json
      - skus.json
      - updates.json
      - updateRuns.json
      - updateSummaries.json
      - deploymentSettings.json
      - edgeDevices.json
      - securitySettings.json
      - hciCommon.json

    reason: Microsoft.AzureStackHCI is the correct name for our RP.
suppressions:
  - code: PathResourceProviderNamePascalCase
    reason: Microsoft.AzureStackHCI was chosen over Microsoft.AzureStackHci or Microsoft.AzureStackHyperConvergedInfrastructure
    from:
      - arcSettings.json
      - clusters.json
      - extensions.json
      - operations.json
      - offers.json
      - publishers.json
      - skus.json
      - updates.json
      - updateRuns.json
      - updateSummaries.json
      - deploymentSettings.json
      - edgeDevices.json
      - securitySettings.json

  - code: ResourceNameRestriction
    reason: ClusterName didn't have a pattern initially, adding the constraint now will cause a breaking change
    from:
      - deploymentSettings.json
      - clusters.json
      - securitySettings.json
      - arcSettings.json
      - extensions.json
      - offers.json
      - publishers.json
      - skus.json 
      - updateRuns.json
      - updates.json
      - updateSummaries.json

  - code: ParametersInPointGet
    reason: already used in GA api version, fixing it will cause a breaking change
    from: 
      - offers.json
      - skus.json

  - code: PatchPropertiesCorrespondToPutProperties
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - clusters.json
  
  - code: PatchBodyParametersSchema
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - clusters.json

  - code: PutResponseCodes
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - clusters.json
      - arcSettings.json
      - updateRuns.json
      - updates.json
      - updateSummaries.json
    
  - code: ConsistentPatchProperties
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - arcSettings.json

  - code: PostResponseCodes
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - arcSettings.json
      - updates.json
  
  - code: DeleteResponseCodes
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - clusters.json
      - extensions.json
      - arcSettings.json
      - updateRuns.json
      - updates.json
      - updateSummaries.json
  
  - code: LroLocationHeader
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - extensions.json
      - clusters.json
      - arcSettings.json
      - updateRuns.json
      - updates.json
      - updateSummaries.json

  - code: ProvisioningStateSpecifiedForLROPut
    reason: already working without the properties section, adding it will break polymorphism
    from:
      - edgeDevices.json

  - code: XmsPageableForListCalls
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - operations.json
      - updateSummaries.json

  - code: RequestSchemaForTrackedResourcesMustHaveTags
    reason: these are not tracked resources, so tags are not needed
    from:
      - updates.json
      - updateRuns.json
      - updateSummaries.json

  - code: TrackedResourcePatchOperation
    reason: these are not tracked resources, so no tags and corresponding patch operation is needed
    from:
      - updates.json
      - updateRuns.json
      - updateSummaries.json

  - code: AvoidAdditionalProperties
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - updates.json

  - code: EvenSegmentedPathForPutOperation
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - updateSummaries.json

  - code: DefinitionsPropertiesNamesCamelCase
    reason: We have a dependency on other team which is already using these values, changing it will break backward compatibility
    from:
      - deploymentSettings.json
    where:
      - $.definitions.QosPolicyOverrides.properties.priorityValue8021Action_Cluster
      - $.definitions.QosPolicyOverrides.properties.priorityValue8021Action_SMB
      - $.definitions.QosPolicyOverrides.properties.bandwidthPercentage_SMB
      - $.definitions.SetInformationJobProperties.properties.priorityValue8021Action_Cluster
      - $.definitions.SetInformationJobProperties.properties.priorityValue8021Action_SMB
      - $.definitions.SetInformationJobProperties.properties.bandwidthPercentage_SMB

  - code: TopLevelResourcesListBySubscription
    reason: It is reporting issue for proxy extension resource which doesn't have use case to ListBySubscription as this resource will always tied to one parent resource only. Additionally, there is a 1:1 relationship between HybridCompute Machines and AzureStackHCI VirtualMachineInstances.
```


### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

```yaml $(tag) == 'package-2024-04'
input-file:
  - stable/2024-04-01/arcSettings.json
  - stable/2024-04-01/clusters.json
  - stable/2024-04-01/deploymentSettings.json
  - stable/2024-04-01/edgeDevices.json
  - stable/2024-04-01/extensions.json
  - stable/2024-04-01/hciCommon.json
  - stable/2024-04-01/offers.json
  - ../operations/stable/2024-04-01/operations.json
  - stable/2024-04-01/publishers.json
  - stable/2024-04-01/securitySettings.json
  - stable/2024-04-01/skus.json
  - stable/2024-04-01/updateRuns.json
  - stable/2024-04-01/updateSummaries.json
  - stable/2024-04-01/updates.json
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
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_azurestackhci']
  - repo: azure-resource-manager-schemas
    after_scripts:
      - node sdkauto_afterscript.js azurestackhci/resource-manager
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)

