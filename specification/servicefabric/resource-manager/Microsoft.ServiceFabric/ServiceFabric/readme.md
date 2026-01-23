# ServiceFabric

> see https://aka.ms/autorest

This is the AutoRest configuration file for Service Fabric.



---
## Getting Started
To build the SDK for ServiceFabricManagementClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the ServiceFabricManagementClient API.

``` yaml
title: ServiceFabricManagementClient
description: Service Fabric Management Client
openapi-type: arm
tag: package-2021-06

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
```

### Tag: package-2023-11-preview

These settings apply only when `--tag=package-2023-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-11-preview'
input-file:
- preview/2023-11-01-preview/servicefabric.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
- stable/2021-06-01/cluster.json
- stable/2021-06-01/application.json
```

### Tag: package-2020-03

These settings apply only when `--tag=package-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-2020-03'
input-file:
- stable/2020-03-01/cluster.json
- stable/2020-03-01/application.json
```

### Tag: package-2020-12-preview

These settings apply only when `--tag=package-2020-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-12-preview'
input-file:
- preview/2020-12-01-preview/cluster.json
- preview/2020-12-01-preview/application.json
```

### Tag: package-2020-01-preview

These settings apply only when `--tag=package-2020-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-preview'
input-file:
- preview/2020-01-01-preview/managedcluster.json
- preview/2020-01-01-preview/nodetype.json
```

### Tag: package-2019-11-preview

These settings apply only when `--tag=package-2019-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-preview'
input-file:
- preview/2019-11-01-preview/cluster.json
- preview/2019-11-01-preview/application.json
```

### Tag: package-2019-06-preview

These settings apply only when `--tag=package-2019-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-06-preview'
input-file:
- preview/2019-06-01-preview/cluster.json
- preview/2019-06-01-preview/application.json
```

### Tag: package-2019-03

These settings apply only when `--tag=package-2019-03` is specified on the command line.

``` yaml $(tag) == 'package-2019-03'
input-file:
- stable/2019-03-01/cluster.json
- stable/2019-03-01/application.json
```

### Tag: package-2019-03-preview

These settings apply only when `--tag=package-2019-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-03-preview'
input-file:
- preview/2019-03-01-preview/cluster.json
- preview/2019-03-01-preview/application.json
```

### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-2018-02'
input-file:
- stable/2018-02-01/cluster.json
- preview/2017-07-01-preview/application.json
```

### Tag: package-2017-07

These settings apply only when `--tag=package-2017-07` is specified on the command line.

``` yaml $(tag) == 'package-2017-07'
input-file:
- preview/2017-07-01-preview/servicefabric.json
```

### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
- stable/2016-09-01/servicefabric.json
```

### Tag: package-2018-02-only

These settings apply only when `--tag=package-2018-02-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-02-only'
input-file:
- stable/2018-02-01/cluster.json
```

### AutoRest v3 Suppressions

```yaml
suppressions:

  - code: ResourceNameRestriction
    reason: Resource names didn't have a pattern initially, adding the constraint now will cause a breaking change.

  - code: PutResponseCodes
    reason: Existing response codes are non-standard and changing would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applicationTypes/{applicationTypeName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applicationTypes/{applicationTypeName}/versions/{version}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}/services/{serviceName}"].put

  - code: PatchResponseCodes
    reason: Cluster, application, and schema PATCH LRO 202 have had response body schema since day 0. Removing would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}"].patch
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}"].patch
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}/services/{serviceName}"].patch
  
  - code: PatchBodyParametersSchema
    reason: The existing API has these properties marked as required.
    where: 
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}"].patch.parameters[4].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}/services/{serviceName}"].patch.parameters[6].schema.properties.properties
  
  - code: ProvisioningStateSpecifiedForLROPut
    reason: No existing operatoins have 201 response code.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applicationTypes/{applicationTypeName}/versions/{version}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}/services/{serviceName}"].put
  
  - code: AvoidAdditionalProperties
    reason: Existing API use additional properties, removing would be breaking change
    where: 
      - $.definitions.ApplicationDeltaHealthPolicy.properties.serviceTypeDeltaHealthPolicies
      - $.definitions.ApplicationHealthPolicy.properties.serviceTypeHealthPolicies
      - $.definitions.ApplicationResourceUpdateProperties.properties.parameters
      - $.definitions.ApplicationTypeVersionResourceProperties.properties.defaultParameterList
      - $.definitions.ArmApplicationHealthPolicy.properties.serviceTypeHealthPolicyMap
      - $.definitions.ClusterHealthPolicy.properties.applicationHealthPolicies
      - $.definitions.ClusterUpgradeDeltaHealthPolicy.properties.applicationDeltaHealthPolicies
      - $.definitions.NodeTypeDescription.properties.placementProperties
      - $.definitions.NodeTypeDescription.properties.capacities
  
  - code: TrackedResourcesMustHavePut
    reason: Resources do have Put operation, but the operations do not seem to be properly detected.
    where:
    - $.definitions.ApplicationTypeVersionResource
    - $.definitions.ApplicationResource
    - $.definitions.ServiceResource
    
  - code: GetCollectionResponseSchema
    reason: Existing ClusterVersions APIs returns list for all list and get. Changing right now would break the API.
    where:
    - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/clusterVersions"]
    - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions"]
  
  - code: PatchIdentityProperty
    reason: Existing application patch has Identity property in properties bad. Would be a breaking change to move it.
    where:
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applications/{applicationName}"].patch.parameters[5]
  
  - code: RequiredPropertiesMissingInResourceModel
    reason: Backwards compatability with previously approved specs. Models did not change. Results are not of type resource. Validation may be incorrectly marking as violation
    where:
    - $.definitions.ClusterCodeVersionsListResult
    - $.definitions.OperationListResult
  
  - code: XmsPageableForListCalls
    reason: Backwards compability with previously approved specs. API modeling did not change.
    where:
    - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/clusters"].get
    - $.paths["/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters"].get
    - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/clusterVersions"].get
    - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions"].get
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_service_fabric']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```


## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)



