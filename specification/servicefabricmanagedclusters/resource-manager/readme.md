# Service Fabric Managed Clusters REST APIs

> see https://aka.ms/autorest

This is the AutoRest configuration file for Service Fabric Managed Clusters.

Azure Service Fabric Managed Clusters are an evolution of the Azure Service Fabric cluster resource model where all the underlying resources for the cluster are abstracted away and managed by Azure on your behalf.

[Azure Service Fabric](http://aka.ms/ServiceFabric) is a distributed systems platform that makes it easy to package, deploy, and manage scalable and reliable microservices.

---

## Getting Started

To build the SDKs for ServiceFabricManagedClustersManagementClient, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the ServiceFabricManagedClustersManagementClient API.

``` yaml
title: ServiceFabricManagedClustersManagementClient
description: Service Fabric Managed Clusters Management Client
openapi-type: arm
tag: package-2025-03-preview

directive:
  - suppress: ListInOperationName
    reason: Modifying the operation names would break the backwards compatibility of the API.
  - suppress: LongRunningResponseStatusCode
    reason: The validation tools do not properly recognize 202 as a supported response code.
  - suppress: SummaryAndDescriptionMustNotBeSame
    reason: There are a lot of APIs with missing summary content. While it is being worked on disabling this to ensure that we catch and fix other violations.
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Modifying the operation names would break the backwards compatibility of the API.
  - suppress: EnumInsteadOfBoolean
    reason: The boolean properties are actually boolean value in the Service Fabric's application model.
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
  - suppress: ParameterNotUsingCommonTypes
    reason: Common type operationId and location parameters have minLength and required properties that are not included in our existing spec. Work planned (https://msazure.visualstudio.com/One/_workitems/edit/24841215)
    where:
      - $.paths.["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterVersions"].get.parameters.2.name
      - $.paths.["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterVersions/{clusterVersion}"].get.parameters.2.name
      - $.paths.["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/managedClusterVersions"].get.parameters.2.name
      - $.paths.["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/managedClusterVersions/{clusterVersion}"].get.parameters.2.name
      - $.paths.["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedUnsupportedVMSizes"].get.parameters.2.name
      - $.paths.["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedUnsupportedVMSizes/{vmSize}"].get.parameters.2.name
      - $.paths.["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterOperations/{operationId}"].get.parameters.3.name
      - $.paths.["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterOperationResults/{operationId}"].get.parameters.3.name
  - suppress: ParameterNotUsingCommonTypes
    reason: Bug in validator is incorrectly associating any non-common type parameters with the wrong expected common type parameter
    where:
      - $.parameters.subscriptionId.name
      - $.parameters.api-version.name
      - $.parameters.resourceGroupNameParameter.name
  - suppress: OperationsApiSchemaUsesCommonTypes
    reason: Common type operations api schema is not compatible with existing API spec. Work planned (https://msazure.visualstudio.com/One/_workitems/edit/24841215)
```

### Tag: package-2025-03-preview

These settings apply only when `--tag=package-2025-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-03-preview'
input-file:
- Microsoft.ServiceFabric/preview/2025-03-01-preview/servicefabricmanagedclusters.json
```

### Tag: package-2024-11-preview

These settings apply only when `--tag=package-2024-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-11-preview'
input-file:
- Microsoft.ServiceFabric/preview/2024-11-01-preview/servicefabricmanagedclusters.json
```

### Tag: package-2024-09-preview

These settings apply only when `--tag=package-2024-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-09-preview'
input-file:
- Microsoft.ServiceFabric/preview/2024-09-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2024-09-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2024-09-01-preview/nodetype.json
```

### Tag: package-2024-06-preview

These settings apply only when `--tag=package-2024-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-06-preview'
input-file:
- Microsoft.ServiceFabric/preview/2024-06-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2024-06-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2024-06-01-preview/nodetype.json
```

### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

``` yaml $(tag) == 'package-2024-04'
input-file:
- Microsoft.ServiceFabric/stable/2024-04-01/managedapplication.json
- Microsoft.ServiceFabric/stable/2024-04-01/managedcluster.json
- Microsoft.ServiceFabric/stable/2024-04-01/nodetype.json
```

### Tag: package-2024-02-preview

These settings apply only when `--tag=package-2024-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-02-preview'
input-file:
- Microsoft.ServiceFabric/preview/2024-02-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2024-02-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2024-02-01-preview/nodetype.json
```

### Tag: package-2023-12-preview

These settings apply only when `--tag=package-2023-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-12-preview'
input-file:
- Microsoft.ServiceFabric/preview/2023-12-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2023-12-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2023-12-01-preview/nodetype.json
```

### Tag: package-2023-11-preview

These settings apply only when `--tag=package-2023-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-11-preview'
input-file:
- Microsoft.ServiceFabric/preview/2023-11-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2023-11-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2023-11-01-preview/nodetype.json
```

### Tag: package-2023-09-preview

These settings apply only when `--tag=package-2023-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-09-preview'
input-file:
- Microsoft.ServiceFabric/preview/2023-09-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2023-09-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2023-09-01-preview/nodetype.json
```

### Tag: package-2023-07-preview

These settings apply only when `--tag=package-2023-07-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-07-preview'
input-file:
- Microsoft.ServiceFabric/preview/2023-07-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2023-07-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2023-07-01-preview/nodetype.json
```

### Tag: package-2023-03-preview

These settings apply only when `--tag=package-2023-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-03-preview'
input-file:
- Microsoft.ServiceFabric/preview/2023-03-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2023-03-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2023-03-01-preview/nodetype.json
```

### Tag: package-2023-02-preview

These settings apply only when `--tag=package-2023-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-02-preview'
input-file:
- Microsoft.ServiceFabric/preview/2023-02-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2023-02-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2023-02-01-preview/nodetype.json
```

### Tag: package-2022-10-preview

These settings apply only when `--tag=package-2022-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-10-preview'
input-file:
- Microsoft.ServiceFabric/preview/2022-10-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2022-10-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2022-10-01-preview/nodetype.json
```

### Tag: package-2022-08-preview

These settings apply only when `--tag=package-2022-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-08-preview'
input-file:
- Microsoft.ServiceFabric/preview/2022-08-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2022-08-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2022-08-01-preview/nodetype.json
```

### Tag: package-2022-06-preview

These settings apply only when `--tag=package-2022-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-06-preview'
input-file:
- Microsoft.ServiceFabric/preview/2022-06-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2022-06-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2022-06-01-preview/nodetype.json
```

### Tag: package-2022-02-preview

These settings apply only when `--tag=package-2022-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-02-preview'
input-file:
- Microsoft.ServiceFabric/preview/2022-02-01-preview/managedapplication.json
- Microsoft.ServiceFabric/preview/2022-02-01-preview/managedcluster.json
- Microsoft.ServiceFabric/preview/2022-02-01-preview/nodetype.json
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

### AutoRest v3 Suppressions

``` yaml
suppressions:
    
  - code: ResourceNameRestriction
    reason: the service does not have a pattern restriction. ARM's default rule should get applied.

  - code: PutResponseSchemaDescription
    reason: service created with the 202 pattern before this rule was introduced.
  
  - code: LroErrorContent
    reason: Work planned (https://msazure.visualstudio.com/One/_workitems/edit/24841215) but its going to take some time because we generate the swagger from an internal repo that currently can't reference the common types.

  - code: LatestVersionOfCommonTypesMustBeUsed
    reason: Work planned (https://msazure.visualstudio.com/One/_workitems/edit/24841215), but our current definition for arm id is not compatible with the validation for the latest common type, we were recommended to use v3 for now.

  - code: XmsPageableForListCalls
    reason: Backwards compatibility with previously approved spec for service.
    where:
      - $.paths.["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterVersions"].get
      - $.paths.["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/managedClusterVersions"].get
      
  - code: GetResponseCodes
    reason: Backwards compatibility with previously approved spec for service.
    where:
      - $.paths.["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterOperationResults/{operationId}"].get

  - code: ProvisioningStateSpecifiedForLROPut
    reason: Backward compatibility with previously approved spec. ProvisioningState is provided as part of the ManagedCluster.ManagedClusterProperties model.
    where:
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}"].put
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/nodeTypes/{nodeTypeName}"].put
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/applicationTypes/{applicationTypeName}/versions/{version}"].put
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/applications/{applicationName}"].put
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/applications/{applicationName}/services/{serviceName}"].put
      
  - code: PatchSkuProperty
    reason: Backwards compatability with previously approved specs. Service does not support sku change in patch.
    where:
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}"].patch.parameters.4
      
  - code: PatchIdentityProperty
    reason: Backwards compatability with previously approved specs. Service does not support identity change in patch.
    where:
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/applications/{applicationName}"].patch.parameters.5
  
  - code: PostOperationIdContainsUrlVerb
    reason: Backwards compatability with previously approved specs.
    where:
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/getazresiliencystatus"].post.operationId
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/getMaintenanceWindowStatus"].post.operationId
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/applyMaintenanceWindow"].post.operationId
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/applications/{applicationName}/fetchUpgradeStatus"].post.operationId
    
  - code: PutResponseCodes
    reason: Backwards compatability with previously approved specs. 
    where:
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}"].put
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/applicationTypes/{applicationTypeName}"].put
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/applicationTypes/{applicationTypeName}/versions/{version}"].put
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/applications/{applicationName}"].put
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/applications/{applicationName}/services/{serviceName}"].put
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/nodeTypes/{nodeTypeName}"].put
  
  - code: AvoidAdditionalProperties
    reason: Backwards compatability with previously approved specs.
    where:
      - $.definitions.ApplicationParameterList
      - $.definitions.ApplicationHealthPolicy.properties.serviceTypeHealthPolicyMap
      - $.definitions.ApplicationResourceProperties.properties.parameters
      - $.definitions.NodeTypeProperties.properties.placementProperties
      - $.definitions.NodeTypeProperties.properties.capacities
      - $.definitions.ServiceTypeHealthPolicyMap
      - $.definitions.UserAssignedIdentityMap
      - $.definitions.VMSSExtensionProperties.properties.settings
      - $.definitions.VMSSExtensionProperties.properties.protectedSettings
      
  - code: BodyTopLevelProperties
    reason: Backwards compatability with previously approved specs. Model did not change.
    where:
      - $.definitions.LongRunningOperationResult
  
  - code: PatchBodyParametersSchema
    reason: Backards compatability with previously approved specs. Model did not change.
    where:
      - $.paths.["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/nodeTypes/{nodeTypeName}"].patch.parameters.5.schema.properties.sku
  
  - code: RequiredPropertiesMissingInResourceModel
    reason: Backwards compatability with previously approved specs. Models did not change. Results are not of type resource, validation may be incorrectly marking as violation.
    where:
      - $.definitions.OperationListResult
      - $.definitions.ManagedClusterCodeVersionResult
      - $.definitions.LongRunningOperationResult
      - $.definitions.NodeTypeListSkuResult
  
  - code: ValidFormats
    reason: duration-constant is an expected format to the .NET SDK generator
    where:
      - $.definitions.ClusterMonitoringPolicy.properties.healthCheckWaitDuration.format
      - $.definitions.ClusterMonitoringPolicy.properties.healthCheckStableDuration.format
      - $.definitions.ClusterMonitoringPolicy.properties.healthCheckRetryTimeout.format
      - $.definitions.ClusterMonitoringPolicy.properties.upgradeTimeout.format
      - $.definitions.ClusterMonitoringPolicy.properties.upgradeDomainTimeout.format
      - $.definitions.RollingUpgradeMonitoringPolicy.properties.healthCheckWaitDuration.format
      - $.definitions.RollingUpgradeMonitoringPolicy.properties.healthCheckStableDuration.format
      - $.definitions.RollingUpgradeMonitoringPolicy.properties.healthCheckRetryTimeout.format
      - $.definitions.RollingUpgradeMonitoringPolicy.properties.upgradeTimeout.format
      - $.definitions.RollingUpgradeMonitoringPolicy.properties.upgradeDomainTimeout.format
      - $.definitions.StatefulServiceProperties.properties.replicaRestartWaitDuration.format
      - $.definitions.StatefulServiceProperties.properties.quorumLossWaitDuration.format
      - $.definitions.StatefulServiceProperties.properties.standByReplicaKeepDuration.format
      - $.definitions.StatefulServiceProperties.properties.servicePlacementTimeLimit.format
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```
