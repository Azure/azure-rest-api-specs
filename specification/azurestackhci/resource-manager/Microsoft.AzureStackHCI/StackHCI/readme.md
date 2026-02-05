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
tag: package-preview-2025-12-01-preview

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
      - hci.json
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
      - edgeDeviceJobs.json
      - validatedSolutionRecipes.json

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

  - code: PutResponseCodes
    from: hci.json
    reason: already used in GA api version, fixing it will cause breaking change
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}"].put

  - code: ProvisioningStateSpecifiedForLROPut
    from: hci.json
    reason: already working without the properties section, adding it will break polymorphism
    where:
      - $.paths["/{resourceUri}/providers/Microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}"].put
      - $.paths["/{resourceUri}/providers/Microsoft.AzureStackHCI/edgeDevices/{edgeDeviceName}/jobs/{jobsName}"].put

  - code: ResourceNameRestriction
    from: hci.json
    reason: Resource name parameters didn't have a pattern initially, adding the constraint now will cause a breaking change
    where: $.paths[?(@property.match(/clusters\/\{clusterName\}/))]

  - code: DeleteResponseCodes
    from: hci.json
    reason: already used in GA api version, fixing it will cause breaking change
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}"].delete

  - code: ConsistentPatchProperties
    from: hci.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}"].patch.parameters[5]["schema"]
    reason: already used in GA api version, fixing it will cause breaking change

  - code: LroLocationHeader
    from: hci.json
    reason: already used in GA api version, fixing it will cause breaking change
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}"].delete.responses["202"].headers
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}"].patch.responses["202"].headers
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/extensions/{extensionName}/upgrade"].post.responses["202"].headers
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default"].delete.responses["202"].headers
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}"].delete.responses["202"].headers
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}"].delete.responses["202"].headers

  - code: PostResponseCodes
    from: hci.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/arcSettings/{arcSettingName}/initializeDisableProcess"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/apply"].post
    reason: already used in GA api version, fixing it will cause breaking change

  - code: ParametersInPointGet
    from: hci.json
    reason: already used in GA api version, fixing it will cause a breaking change
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}"].get.parameters
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/publishers/{publisherName}/offers/{offerName}/skus/{skuName}"].get.parameters

  - code: PutResponseCodes
    from: hci.json
    reason: already used in GA api version, fixing it will cause breaking change
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}"].put

  - code: DeleteResponseCodes
    from: hci.json
    reason: already used in GA api version, fixing it will cause breaking change
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}"].delete

  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: hci.json
    reason: these are not tracked resources, so tags are not needed
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updateSummaries/default"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updates/{updateName}/updateRuns/{updateRunName}"].put

  - code: TrackedResourcePatchOperation
    from: hci.json
    reason: these are not tracked resources, so no tags and corresponding patch operation is needed
    where:
      - $.definitions.UpdateSummaries
      - $.definitions.Update
      - $.definitions.UpdateRun

  - code: DefinitionsPropertiesNamesCamelCase
    from: hci.json
    reason: We have a dependency on other team which is already using these values, changing it will break backward compatibility
    where:
      - $.definitions.QosPolicyOverrides.properties.priorityValue8021Action_Cluster
      - $.definitions.QosPolicyOverrides.properties.priorityValue8021Action_SMB
      - $.definitions.QosPolicyOverrides.properties.bandwidthPercentage_SMB

  - code: AvoidAdditionalProperties
    from: hci.json
    reason: already used in GA api version, fixing it will cause breaking change
    where:
      - $.definitions.UpdateProperties.properties
    
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
      - edgeDeviceJobs.json

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

  - code: PatchBodyParametersSchema
    from: 
      - clusters.json
    reason: Making the body optional now would cause a breaking change in backward compatibility
```

### Tag: package-2026-02-01

These settings apply only when `--tag=package-2026-02-01` is specified on the command line.

```yaml $(tag) == 'package-2026-02-01'
input-file:
  - stable/2026-02-01/hci.json
```

### Tag: package-preview-2025-12-01-preview

These settings apply only when `--tag=package-preview-2025-12-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-12-01-preview'
input-file:
  - preview/2025-12-01-preview/hci.json
```

### Tag: package-preview-2025-11-01-preview

These settings apply only when `--tag=package-preview-2025-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-11-01-preview'
input-file:
  - preview/2025-11-01-preview/hci.json
```

### Tag: package-2025-10-01

These settings apply only when `--tag=package-2025-10-01` is specified on the command line.

```yaml $(tag) == 'package-2025-10-01'
input-file:
  - stable/2025-10-01/arcSettings.json
  - stable/2025-10-01/clusters.json
  - stable/2025-10-01/deploymentSettings.json
  - stable/2025-10-01/edgeDeviceJobs.json
  - stable/2025-10-01/edgeDevices.json
  - stable/2025-10-01/extensions.json
  - stable/2025-10-01/hciCommon.json
  - stable/2025-10-01/offers.json
  - stable/2025-10-01/operations.json
  - stable/2025-10-01/publishers.json
  - stable/2025-10-01/securitySettings.json
  - stable/2025-10-01/skus.json
  - stable/2025-10-01/updateRuns.json
  - stable/2025-10-01/updates.json
  - stable/2025-10-01/updateSummaries.json
  - stable/2025-10-01/validatedSolutionRecipes.json
```

### Tag: package-preview-2025-09-15-preview

These settings apply only when `--tag=package-preview-2025-09-15-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-09-15-preview'
input-file:
  - preview/2025-09-15-preview/arcSettings.json
  - preview/2025-09-15-preview/clusters.json
  - preview/2025-09-15-preview/deploymentSettings.json
  - preview/2025-09-15-preview/edgeDeviceJobs.json
  - preview/2025-09-15-preview/edgeDevices.json
  - preview/2025-09-15-preview/extensions.json
  - preview/2025-09-15-preview/hciCommon.json
  - preview/2025-09-15-preview/offers.json
  - preview/2025-09-15-preview/operations.json
  - preview/2025-09-15-preview/publishers.json
  - preview/2025-09-15-preview/securitySettings.json
  - preview/2025-09-15-preview/skus.json
  - preview/2025-09-15-preview/updateRuns.json
  - preview/2025-09-15-preview/updates.json
  - preview/2025-09-15-preview/updateSummaries.json
  - preview/2025-09-15-preview/validatedSolutionRecipes.json
```

### Tag: package-preview-2025-02-01-preview

These settings apply only when `--tag=package-preview-2025-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-02-01-preview'
input-file:
  - preview/2025-02-01-preview/arcSettings.json
  - preview/2025-02-01-preview/clusters.json
  - preview/2025-02-01-preview/deploymentSettings.json
  - preview/2025-02-01-preview/edgeDeviceJobs.json
  - preview/2025-02-01-preview/edgeDevices.json
  - preview/2025-02-01-preview/extensions.json
  - preview/2025-02-01-preview/hciCommon.json
  - preview/2025-02-01-preview/offers.json
  - preview/2025-02-01-preview/operations.json
  - preview/2025-02-01-preview/publishers.json
  - preview/2025-02-01-preview/securitySettings.json
  - preview/2025-02-01-preview/skus.json
  - preview/2025-02-01-preview/updateRuns.json
  - preview/2025-02-01-preview/updates.json
  - preview/2025-02-01-preview/updateSummaries.json
  - preview/2025-02-01-preview/validatedSolutionRecipes.json
```

### Tag: package-preview-2024-12-01-preview

These settings apply only when `--tag=package-preview-2024-12-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-12-01-preview'
input-file:
  - preview/2024-12-01-preview/arcSettings.json
  - preview/2024-12-01-preview/clusters.json
  - preview/2024-12-01-preview/deploymentSettings.json
  - preview/2024-12-01-preview/edgeDeviceJobs.json
  - preview/2024-12-01-preview/edgeDevices.json
  - preview/2024-12-01-preview/extensions.json
  - preview/2024-12-01-preview/hciCommon.json
  - preview/2024-12-01-preview/offers.json
  - preview/2024-12-01-preview/operations.json
  - preview/2024-12-01-preview/publishers.json
  - preview/2024-12-01-preview/securitySettings.json
  - preview/2024-12-01-preview/skus.json
  - preview/2024-12-01-preview/updateRuns.json
  - preview/2024-12-01-preview/updates.json
  - preview/2024-12-01-preview/updateSummaries.json
```

### Tag: package-preview-2024-09

These settings apply only when `--tag=package-preview-2024-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-09'
input-file:
  - preview/2024-09-01-preview/arcSettings.json
  - preview/2024-09-01-preview/clusters.json
  - preview/2024-09-01-preview/deploymentSettings.json
  - preview/2024-09-01-preview/edgeDevices.json
  - preview/2024-09-01-preview/edgeDeviceJobs.json
  - preview/2024-09-01-preview/extensions.json
  - preview/2024-09-01-preview/hciCommon.json
  - preview/2024-09-01-preview/offers.json
  - preview/2024-09-01-preview/operations.json
  - preview/2024-09-01-preview/publishers.json
  - preview/2024-09-01-preview/securitySettings.json
  - preview/2024-09-01-preview/skus.json
  - preview/2024-09-01-preview/updateRuns.json
  - preview/2024-09-01-preview/updateSummaries.json
  - preview/2024-09-01-preview/updates.json
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
  - stable/2024-04-01/operations.json
  - stable/2024-04-01/publishers.json
  - stable/2024-04-01/securitySettings.json
  - stable/2024-04-01/skus.json
  - stable/2024-04-01/updateRuns.json
  - stable/2024-04-01/updateSummaries.json
  - stable/2024-04-01/updates.json
```

### Tag: package-preview-2024-02

These settings apply only when `--tag=package-preview-2024-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2024-02'
input-file:
  - preview/2024-02-15-preview/arcSettings.json
  - preview/2024-02-15-preview/clusters.json
  - preview/2024-02-15-preview/deploymentSettings.json
  - preview/2024-02-15-preview/edgeDevices.json
  - preview/2024-02-15-preview/extensions.json
  - preview/2024-02-15-preview/offers.json
  - preview/2024-02-15-preview/operations.json
  - preview/2024-02-15-preview/publishers.json
  - preview/2024-02-15-preview/securitySettings.json
  - preview/2024-02-15-preview/skus.json
  - preview/2024-02-15-preview/updateRuns.json
  - preview/2024-02-15-preview/updateSummaries.json
  - preview/2024-02-15-preview/updates.json
  - preview/2024-02-15-preview/hciCommon.json
```

### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-01'
input-file:
  - stable/2024-01-01/arcSettings.json
  - stable/2024-01-01/clusters.json
  - stable/2024-01-01/deploymentSettings.json
  - stable/2024-01-01/edgeDevices.json
  - stable/2024-01-01/extensions.json
  - stable/2024-01-01/offers.json
  - stable/2024-01-01/operations.json
  - stable/2024-01-01/publishers.json
  - stable/2024-01-01/securitySettings.json
  - stable/2024-01-01/skus.json
  - stable/2024-01-01/updateRuns.json
  - stable/2024-01-01/updateSummaries.json
  - stable/2024-01-01/updates.json
```

### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-11'
input-file:
  - preview/2023-11-01-preview/arcSettings.json
  - preview/2023-11-01-preview/clusters.json
  - preview/2023-11-01-preview/deploymentSettings.json
  - preview/2023-11-01-preview/edgeDevices.json
  - preview/2023-11-01-preview/extensions.json
  - preview/2023-11-01-preview/offers.json
  - preview/2023-11-01-preview/operations.json
  - preview/2023-11-01-preview/publishers.json
  - preview/2023-11-01-preview/securitySettings.json
  - preview/2023-11-01-preview/skus.json
  - preview/2023-11-01-preview/updateRuns.json
  - preview/2023-11-01-preview/updateSummaries.json
  - preview/2023-11-01-preview/updates.json
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - preview/2023-08-01-preview/arcSettings.json
  - preview/2023-08-01-preview/clusters.json
  - preview/2023-08-01-preview/extensions.json
  - preview/2023-08-01-preview/offers.json
  - preview/2023-08-01-preview/operations.json
  - preview/2023-08-01-preview/publishers.json
  - preview/2023-08-01-preview/skus.json
  - preview/2023-08-01-preview/updateRuns.json
  - preview/2023-08-01-preview/updateSummaries.json
  - preview/2023-08-01-preview/updates.json
  - preview/2023-08-01-preview/deploymentSettings.json
  - preview/2023-08-01-preview/edgeDevices.json
```

### Tag: package-2023-08

These settings apply only when `--tag=package-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-2023-08'
input-file:
  - stable/2023-08-01/arcSettings.json
  - stable/2023-08-01/clusters.json
  - stable/2023-08-01/extensions.json
  - stable/2023-08-01/offers.json
  - stable/2023-08-01/operations.json
  - stable/2023-08-01/publishers.json
  - stable/2023-08-01/skus.json
  - stable/2023-08-01/updateRuns.json
  - stable/2023-08-01/updateSummaries.json
  - stable/2023-08-01/updates.json
```

### Tag: package-2023-06

These settings apply only when `--tag=package-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-2023-06'
input-file:
  - stable/2023-06-01/arcSettings.json
  - stable/2023-06-01/clusters.json
  - stable/2023-06-01/extensions.json
  - stable/2023-06-01/offers.json
  - stable/2023-06-01/operations.json
  - stable/2023-06-01/publishers.json
  - stable/2023-06-01/skus.json
  - stable/2023-06-01/updateRuns.json
  - stable/2023-06-01/updateSummaries.json
  - stable/2023-06-01/updates.json
```

### Tag: package-2023-03

These settings apply only when `--tag=package-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-2023-03'
input-file:
  - stable/2023-03-01/arcSettings.json
  - stable/2023-03-01/clusters.json
  - stable/2023-03-01/extensions.json
  - stable/2023-03-01/offers.json
  - stable/2023-03-01/operations.json
  - stable/2023-03-01/publishers.json
  - stable/2023-03-01/skus.json
  - stable/2023-03-01/updateRuns.json
  - stable/2023-03-01/updateSummaries.json
  - stable/2023-03-01/updates.json
```

### Tag: package-2023-02

These settings apply only when `--tag=package-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-2023-02'
input-file:
  - stable/2023-02-01/arcSettings.json
  - stable/2023-02-01/clusters.json
  - stable/2023-02-01/extensions.json
  - stable/2023-02-01/offers.json
  - stable/2023-02-01/operations.json
  - stable/2023-02-01/publishers.json
  - stable/2023-02-01/skus.json
  - stable/2023-02-01/updateRuns.json
  - stable/2023-02-01/updateSummaries.json
  - stable/2023-02-01/updates.json
```

### Tag: package-preview-2022-12-15

These settings apply only when `--tag=package-preview-2022-12-15` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-12-15'
input-file:
  - preview/2022-12-15-preview/arcSettings.json
  - preview/2022-12-15-preview/clusters.json
  - preview/2022-12-15-preview/extensions.json
  - preview/2022-12-15-preview/offers.json
  - preview/2022-12-15-preview/operations.json
  - preview/2022-12-15-preview/publishers.json
  - preview/2022-12-15-preview/skus.json
  - preview/2022-12-15-preview/updateRuns.json
  - preview/2022-12-15-preview/updateSummaries.json
  - preview/2022-12-15-preview/updates.json
```

### Tag: package-2022-12

These settings apply only when `--tag=package-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-2022-12'
input-file:
  - stable/2022-12-01/arcSettings.json
  - stable/2022-12-01/clusters.json
  - stable/2022-12-01/extensions.json
  - stable/2022-12-01/offers.json
  - stable/2022-12-01/operations.json
  - stable/2022-12-01/publishers.json
  - stable/2022-12-01/skus.json
  - stable/2022-12-01/updateRuns.json
  - stable/2022-12-01/updateSummaries.json
  - stable/2022-12-01/updates.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10'
input-file:
  - stable/2022-10-01/arcSettings.json
  - stable/2022-10-01/clusters.json
  - stable/2022-10-01/extensions.json
  - stable/2022-10-01/operations.json
  - stable/2022-10-01/offers.json
  - stable/2022-10-01/publishers.json
  - stable/2022-10-01/skus.json
  - stable/2022-10-01/updateRuns.json
  - stable/2022-10-01/updateSummaries.json
  - stable/2022-10-01/updates.json
```

### Tag: package-2022-09

These settings apply only when `--tag=package-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-2022-09'
input-file:
  - stable/2022-09-01/arcSettings.json
  - stable/2022-09-01/clusters.json
  - stable/2022-09-01/extensions.json
  - stable/2022-09-01/operations.json
```

### Tag: package-2022-05

These settings apply only when `--tag=package-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-2022-05'
input-file:
  - stable/2022-05-01/arcSettings.json
  - stable/2022-05-01/clusters.json
  - stable/2022-05-01/extensions.json
  - stable/2022-05-01/operations.json
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-2022-03'
input-file:
  - stable/2022-03-01/arcSettings.json
  - stable/2022-03-01/clusters.json
  - stable/2022-03-01/extensions.json
  - stable/2022-03-01/operations.json
```

### Tag: package-2022-01

These settings apply only when `--tag=package-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-01'
input-file:
  - stable/2022-01-01/arcSettings.json
  - stable/2022-01-01/clusters.json
  - stable/2022-01-01/extensions.json
  - stable/2022-01-01/operations.json
```

### Tag: package-preview-2021-09

These settings apply only when `--tag=package-preview-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-09'
input-file:
  - preview/2021-09-01-preview/arcSettings.json
  - preview/2021-09-01-preview/clusters.json
  - preview/2021-09-01-preview/extensions.json
  - preview/2021-09-01-preview/operations.json
```

### Tag: package-2021-09

These settings apply only when `--tag=package-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-2021-09'
input-file:
  - stable/2021-09-01/arcSettings.json
  - stable/2021-09-01/clusters.json
  - stable/2021-09-01/extensions.json
  - stable/2021-09-01/operations.json
```

### Tag: package-preview-2021-01

These settings apply only when `--tag=package-preview-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-01'
input-file:
  - preview/2021-01-01-preview/arcSettings.json
  - preview/2021-01-01-preview/clusters.json
  - preview/2021-01-01-preview/extensions.json
  - preview/2021-01-01-preview/operations.json
```

### Tag: package-2020-10-01

These settings apply only when `--tag=package-2020-10-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-10-01'
input-file:
  - stable/2020-10-01/azurestackhci.json
```

### Tag: package-2020-03-01-preview

These settings apply only when `--tag=package-2020-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-01-preview'
input-file:
  - preview/2020-03-01-preview/azurestackhci.json
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

