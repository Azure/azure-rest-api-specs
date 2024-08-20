# HDInsight On Aks

> see https://aka.ms/autorest

This is the AutoRest configuration file for HDInsight On Aks.

---

## Getting Started

To build the SDK for HDInsight, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the HDInsight On Aks API.

``` yaml
title: HDInsightContainersManagementClient
description: HDInsight Containers Management Client
openapi-type: arm
openapi-subtype: rpaas
azure-arm: true
tag: package-preview-2024-05
```

``` yaml
modelerfour:
  flatten-models: false
```

### Suppression


### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - preview/2024-05-01-preview/hdinsight.json

suppressions:
  - code: ResourceNameRestriction
    reason: Keep compatibility with old API version.
  - code: OperationIdNounVerb
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusterpools/{clusterPoolName}/clusters"].get.operationId
    reason: The operation id is valid.
  - code: EnumInsteadOfBoolean
  - code: TrackedResourcePatchOperation
    where:
      - $.definitions.Cluster
    reason: This is a false positive, and there is ClusterPatch defined for patching cluster.
  - code: PatchBodyParametersSchema
    reason: We refers to the same models in PUT operation, and the errors checked are allowed by our service.
  - code: DeleteResponseCodes
    reason: If the resource only exist in arm, and doesn't have backend resources, we return 200 in delete operation.
  - code: EnumInsteadOfBoolean
    where:
      - $.definitions.ClusterAccessProfile.properties.enableInternalIngress
      - $.definitions.ClusterPoolNetworkProfile.properties.enablePrivateApiServer
      - $.definitions.ClusterRangerPluginProfile.properties.enabled
      - $.definitions.RangerUsersyncSpec.properties.enabled
      - $.definitions.KafkaProfile.properties.enableKRaft
      - $.definitions.KafkaProfile.enablePublicEndpoints
      - $.definitions.ClusterPoolAKSPatchVersionUpgradeProperties.upgradeClusterPool
      - $.definitions.ClusterPoolAKSPatchVersionUpgradeProperties.upgradeAllClusterNodes
    reason: They are used for enabling or disabling a feature. Using a boolean type is more user friendly, and they will be not extended to other values.
```
### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-11'
input-file:
  - preview/2023-11-01-preview/hdinsight.json
  
suppressions:
  - code: ResourceNameRestriction
    reason: Keep compatibility with old API version.
  - code: OperationIdNounVerb
    where: 
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusterpools/{clusterPoolName}/clusters"].get.operationId
    reason: The operation id is valid.
  - code: EnumInsteadOfBoolean
  - code: TrackedResourcePatchOperation
    where: 
    - $.definitions.Cluster
    reason: This is a false positive, and there is ClusterPatch defined for patching cluster.
  - code: DeleteResponseCodes
    reason: If the resource only exist in arm, and doesn't have backend resources, we return 200 in delete operation.
  - code: EnumInsteadOfBoolean
    where: 
    - $.definitions.ClusterAccessProfile.properties.enableInternalIngress
    - $.definitions.ClusterPoolNetworkProfile.properties.enablePrivateApiServer
    - $.definitions.ClusterRangerPluginProfile.properties.enabled
    - $.definitions.RangerUsersyncSpec.properties.enabled
    - $.definitions.KafkaProfile.properties.enableKRaft
    - $.definitions.KafkaProfile.enablePublicEndpoints
    - $.definitions.ClusterPoolAKSPatchVersionUpgradeProperties.upgradeClusterPool
    - $.definitions.ClusterPoolAKSPatchVersionUpgradeProperties.upgradeAllClusterNodes
    reason: They are used for enabling or disabling a feature. Using a boolean type is more user friendly, and they will be not extended to other values.
```

### Tag: package-2023-06-preview

These settings apply only when `--tag=package-2023-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-06-preview'
input-file:
  - preview/2023-06-01-preview/hdinsight.json
suppressions:
  - code: ResourceNameRestriction
    reason: Keep compatibility with old API version.
  - code: PatchBodyParametersSchema
    reason: The "location" property is a must for a tracked resource.
  - code: TrackedResourcePatchOperation
    reason: This is a false positive, the "tags" property is defined in TrackedResource.
  - code: OperationIdNounVerb
    reason: This is false alarm. We checked that the operation id "Clusters_ListByClusterPoolName" is correct.
  - code: GetCollectionOnlyHasValueAndNextLink
    reason: This is false alarm.
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Azure.ResourceManager.HDInsight.Containers
  output-folder: $(csharp-sdks-folder)/hdinsight/Azure.ResourceManager.HDInsight.Containers/src/Generated
  clear-output-folder: true
```
