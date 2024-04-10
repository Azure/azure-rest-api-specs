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

```yaml
title: AzureStackHCIClient
description: Azure Stack HCI management service
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2024-03
```

## Suppression

```yaml
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
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/deploymentSettings/{deploymentSettingsName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/uploadCertificate"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/createClusterIdentity"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/extendSoftwareAssuranceBenefit"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/securitySettings/{securitySettingsName}"]

  - code: PatchPropertiesCorrespondToPutProperties
    reason: already used in GA api version, fixing it will cause breaking change
    from:
      - clusters.json

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

### Tag: package-preview-2024-03

These settings apply only when `--tag=package-preview-2024-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-03'
input-file:
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/arcSettings.json
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/clusters.json
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/deploymentSettings.json
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/edgeDevices.json
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/extensions.json
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/offers.json
  - Microsoft.AzureStackHCI/operations/preview/2024-03-01-preview/operations.json
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/publishers.json
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/skus.json
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/updateRuns.json
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/updateSummaries.json
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/updates.json
  - Microsoft.AzureStackHCI/StackHCI/preview/2024-03-01-preview/securitySettings.json
```

---
