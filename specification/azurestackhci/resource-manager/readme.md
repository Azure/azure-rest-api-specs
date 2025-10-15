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
tag: package-preview-2024-03
```

## Suppression

``` yaml
directive:
  - suppress: R3020
    from:
      - arcSettings.json
      - clusters.json
      - extensions.json
      - galleryImages.json
      - logicalNetworks.json
      - marketplaceGalleryImages.json
      - networkInterfaces.json
      - operations.json
      - storageContainers.json
      - virtualHardDisks.json
      - virtualMachines.json
      - virtualMachineInstances.json
      - virtualNetworks.json
      - offers.json
      - publishers.json
      - skus.json
      - updates.json
      - updateRuns.json
      - updateSummaries.json
      - deploymentSettings.json
      - edgeDevices.json
      - securitySettings.json
      - hci.json
      - hciCommon.json
      - edgeNodePool.json

    reason: Microsoft.AzureStackHCI is the correct name for our RP.
suppressions:
  - code: PathResourceProviderNamePascalCase
    reason: Microsoft.AzureStackHCI was chosen over Microsoft.AzureStackHci or Microsoft.AzureStackHyperConvergedInfrastructure
    from:
      - arcSettings.json
      - clusters.json
      - extensions.json
      - galleryImages.json
      - logicalNetworks.json
      - marketplaceGalleryImages.json
      - networkInterfaces.json
      - operations.json
      - storageContainers.json
      - virtualHardDisks.json
      - virtualMachines.json
      - virtualMachineInstances.json
      - virtualNetworks.json
      - offers.json
      - publishers.json
      - skus.json
      - updates.json
      - updateRuns.json
      - updateSummaries.json
      - deploymentSettings.json
      - edgeDevices.json
      - securitySettings.json
      - hci.json
      - common.json
      - edgeNodePool.json

  - code: ResourceNameRestriction
    reason: ClusterName didn't have a pattern initially, adding the constraint now will cause a breaking change
    from:
      - deploymentSettings.json
      - hci.json
      - clusters.json
      - securitySettings.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings/{deploymentSettingsName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/jobs"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/jobs/{jobsName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/uploadCertificate"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/createClusterIdentity"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/extendSoftwareAssuranceBenefit"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings/{securitySettingsName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings/{securitySettingsName}/remediate"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/configureRemoteSupport"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/triggerLogCollection"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updateSecretsLocations"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/updateConfidentialVm"]

  - code: PatchPropertiesCorrespondToPutProperties
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - clusters.json

  - code: PatchBodyParametersSchema
    reason: We have used kind property as discriminator to support polymorphic resource and during patch also need to pass discriminator to allow patch on certain polymorphic resource type property.
    from:
      - hci.json

  - code: DeleteResponseCodes
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - clusters.json
  
  - code: ProvisioningStateSpecifiedForLROPut
    reason: already working without the properties section, adding it will break polymorphism
    from:
      - edgeDevices.json
      - hci.json
  - code: BodyTopLevelProperties
    reason: The BodyTopLevelProperties rule is mistakenly flagging paged responses #722

  - code: DefinitionsPropertiesNamesCamelCase
    reason: We have a dependency on other team which is already using these values, changing it will break backward compatibility
    from:
      - deploymentSettings.json
      - hci.json
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

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
#  - repo: azure-sdk-for-java
#  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
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

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)