# EventHub

> see https://aka.ms/autorest

This is the AutoRest configuration file for EventHub.



---
## Getting Started
To build the SDK for EventHub, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the EventHub API.

``` yaml
openapi-type: arm
tag: package-2025-05-preview
```

### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

``` yaml $(tag) == 'package-2017-04'
input-file:
- Microsoft.EventHub/stable/2017-04-01/AuthorizationRules.json
- Microsoft.EventHub/stable/2017-04-01/CheckNameAvailability.json
- Microsoft.EventHub/stable/2017-04-01/consumergroups.json
- Microsoft.EventHub/stable/2017-04-01/disasterRecoveryConfigs.json
- Microsoft.EventHub/stable/2017-04-01/eventhubs.json
- Microsoft.EventHub/stable/2017-04-01/namespaces.json
- Microsoft.EventHub/stable/2017-04-01/networkRuleSets.json
- Microsoft.EventHub/stable/2017-04-01/operations.json
- Microsoft.EventHub/stable/2017-04-01/sku.json
```


### Tag: package-2015-08

These settings apply only when `--tag=package-2015-08` is specified on the command line.

``` yaml $(tag) == 'package-2015-08'
input-file:
- Microsoft.EventHub/stable/2015-08-01/EventHub.json
```


### Tag: package-2014-09

These settings apply only when `--tag=package-2014-09` is specified on the command line.

``` yaml $(tag) == 'package-2014-09'
input-file:
- Microsoft.EventHub/stable/2014-09-01/EventHub.json
```

### Tag: package-2021-01-preview

These settings apply only when `--tag=package-2021-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-preview'
input-file:
- Microsoft.EventHub/preview/2021-01-01-preview/namespaces-preview.json
- Microsoft.EventHub/preview/2021-01-01-preview/operations.json
- Microsoft.EventHub/preview/2021-01-01-preview/eventhubs.json
- Microsoft.EventHub/preview/2021-01-01-preview/disasterRecoveryConfigs.json
- Microsoft.EventHub/preview/2021-01-01-preview/networkrulessets-preview.json
- Microsoft.EventHub/preview/2021-01-01-preview/AuthorizationRules.json
- Microsoft.EventHub/preview/2021-01-01-preview/consumergroups.json
- Microsoft.EventHub/preview/2021-01-01-preview/CheckNameAvailability.json
```

### Tag: package-2021-06-preview

These settings apply only when `--tag=package-2021-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-preview'
input-file:
- Microsoft.EventHub/preview/2021-06-01-preview/AvailableClusterRegions-preview.json
- Microsoft.EventHub/preview/2021-06-01-preview/Clusters-preview.json
- Microsoft.EventHub/preview/2021-06-01-preview/quotaConfiguration-preview.json
- Microsoft.EventHub/preview/2021-06-01-preview/namespaces-preview.json
- Microsoft.EventHub/preview/2021-06-01-preview/operations.json
- Microsoft.EventHub/preview/2021-06-01-preview/eventhubs.json
- Microsoft.EventHub/preview/2021-06-01-preview/disasterRecoveryConfigs.json
- Microsoft.EventHub/preview/2021-06-01-preview/networkrulessets-preview.json
- Microsoft.EventHub/preview/2021-06-01-preview/AuthorizationRules.json
- Microsoft.EventHub/preview/2021-06-01-preview/consumergroups.json
- Microsoft.EventHub/preview/2021-06-01-preview/CheckNameAvailability.json
```

### Tag: package-2018-01-preview

These settings apply only when `--tag=package-2018-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-preview'
input-file:
- Microsoft.EventHub/preview/2018-01-01-preview/AvailableClusterRegions-preview.json
- Microsoft.EventHub/preview/2018-01-01-preview/Clusters-preview.json
- Microsoft.EventHub/preview/2018-01-01-preview/ipfilterrules-preview.json
- Microsoft.EventHub/preview/2018-01-01-preview/namespaces-preview.json
- Microsoft.EventHub/preview/2018-01-01-preview/quotaConfiguration-preview.json
- Microsoft.EventHub/preview/2018-01-01-preview/virtualnetworkrules-preview.json
- Microsoft.EventHub/preview/2018-01-01-preview/networkrulessets-preview.json
- Microsoft.EventHub/preview/2018-01-01-preview/AuthorizationRules.json
- Microsoft.EventHub/preview/2018-01-01-preview/CheckNameAvailability.json
- Microsoft.EventHub/preview/2018-01-01-preview/consumergroups.json
- Microsoft.EventHub/preview/2018-01-01-preview/disasterRecoveryConfigs.json
- Microsoft.EventHub/preview/2018-01-01-preview/operations.json
- Microsoft.EventHub/preview/2018-01-01-preview/eventhubs.json
- Microsoft.EventHub/preview/2018-01-01-preview/sku.json
```

### Tag: package-2021-11

These settings apply only when `--tag=package-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-2021-11'
input-file:
- Microsoft.EventHub/stable/2021-11-01/AvailableClusterRegions-preview.json
- Microsoft.EventHub/stable/2021-11-01/Clusters-preview.json
- Microsoft.EventHub/stable/2021-11-01/quotaConfiguration-preview.json
- Microsoft.EventHub/stable/2021-11-01/namespaces-preview.json
- Microsoft.EventHub/stable/2021-11-01/operations.json
- Microsoft.EventHub/stable/2021-11-01/eventhubs.json
- Microsoft.EventHub/stable/2021-11-01/disasterRecoveryConfigs.json
- Microsoft.EventHub/stable/2021-11-01/networkrulessets-preview.json
- Microsoft.EventHub/stable/2021-11-01/AuthorizationRules.json
- Microsoft.EventHub/stable/2021-11-01/consumergroups.json
- Microsoft.EventHub/stable/2021-11-01/CheckNameAvailability.json
- Microsoft.EventHub/stable/2021-11-01/SchemaRegistry.json
```

### Tag: package-2022-01-preview

These settings apply only when `--tag=package-2022-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-01-preview'
input-file:
- Microsoft.EventHub/preview/2022-01-01-preview/AvailableClusterRegions-preview.json
- Microsoft.EventHub/preview/2022-01-01-preview/Clusters-preview.json
- Microsoft.EventHub/preview/2022-01-01-preview/namespaces-preview.json
- Microsoft.EventHub/preview/2022-01-01-preview/quotaConfiguration-preview.json
- Microsoft.EventHub/preview/2022-01-01-preview/networkrulessets-preview.json
- Microsoft.EventHub/preview/2022-01-01-preview/AuthorizationRules.json
- Microsoft.EventHub/preview/2022-01-01-preview/CheckNameAvailability.json
- Microsoft.EventHub/preview/2022-01-01-preview/consumergroups.json
- Microsoft.EventHub/preview/2022-01-01-preview/disasterRecoveryConfigs.json
- Microsoft.EventHub/preview/2022-01-01-preview/operations.json
- Microsoft.EventHub/preview/2022-01-01-preview/eventhubs.json
- Microsoft.EventHub/preview/2022-01-01-preview/SchemaRegistry.json
- Microsoft.EventHub/preview/2022-01-01-preview/ApplicationGroups.json
```

### Tag: package-2022-10-preview

These settings apply only when `--tag=package-2022-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-10-preview'
input-file:
- Microsoft.EventHub/preview/2022-10-01-preview/AvailableClusterRegions-preview.json
- Microsoft.EventHub/preview/2022-10-01-preview/Clusters-preview.json
- Microsoft.EventHub/preview/2022-10-01-preview/namespaces-preview.json
- Microsoft.EventHub/preview/2022-10-01-preview/quotaConfiguration-preview.json
- Microsoft.EventHub/preview/2022-10-01-preview/networkrulessets-preview.json
- Microsoft.EventHub/preview/2022-10-01-preview/AuthorizationRules.json
- Microsoft.EventHub/preview/2022-10-01-preview/CheckNameAvailability.json
- Microsoft.EventHub/preview/2022-10-01-preview/consumergroups.json
- Microsoft.EventHub/preview/2022-10-01-preview/disasterRecoveryConfigs.json
- Microsoft.EventHub/preview/2022-10-01-preview/operations.json
- Microsoft.EventHub/preview/2022-10-01-preview/eventhubs.json
- Microsoft.EventHub/preview/2022-10-01-preview/SchemaRegistry.json
- Microsoft.EventHub/preview/2022-10-01-preview/ApplicationGroups.json
```

### Tag: package-2023-01-preview

These settings apply only when `--tag=package-2023-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-01-preview'
input-file:
- Microsoft.EventHub/preview/2023-01-01-preview/AvailableClusterRegions-preview.json
- Microsoft.EventHub/preview/2023-01-01-preview/Clusters-preview.json
- Microsoft.EventHub/preview/2023-01-01-preview/namespaces-preview.json
- Microsoft.EventHub/preview/2023-01-01-preview/quotaConfiguration-preview.json
- Microsoft.EventHub/preview/2023-01-01-preview/networkrulessets-preview.json
- Microsoft.EventHub/preview/2023-01-01-preview/AuthorizationRules.json
- Microsoft.EventHub/preview/2023-01-01-preview/CheckNameAvailability.json
- Microsoft.EventHub/preview/2023-01-01-preview/consumergroups.json
- Microsoft.EventHub/preview/2023-01-01-preview/disasterRecoveryConfigs.json
- Microsoft.EventHub/preview/2023-01-01-preview/operations.json
- Microsoft.EventHub/preview/2023-01-01-preview/eventhubs.json
- Microsoft.EventHub/preview/2023-01-01-preview/SchemaRegistry.json
- Microsoft.EventHub/preview/2023-01-01-preview/ApplicationGroups.json
```

### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-01'
input-file:
- Microsoft.EventHub/stable/2024-01-01/AvailableClusterRegions.json
- Microsoft.EventHub/stable/2024-01-01/Clusters.json
- Microsoft.EventHub/stable/2024-01-01/namespaces.json
- Microsoft.EventHub/stable/2024-01-01/quotaConfiguration.json
- Microsoft.EventHub/stable/2024-01-01/networkrulessets.json
- Microsoft.EventHub/stable/2024-01-01/AuthorizationRules.json
- Microsoft.EventHub/stable/2024-01-01/CheckNameAvailability.json
- Microsoft.EventHub/stable/2024-01-01/consumergroups.json
- Microsoft.EventHub/stable/2024-01-01/disasterRecoveryConfigs.json
- Microsoft.EventHub/stable/2024-01-01/operations.json
- Microsoft.EventHub/stable/2024-01-01/eventhubs.json
- Microsoft.EventHub/stable/2024-01-01/SchemaRegistry.json
- Microsoft.EventHub/stable/2024-01-01/ApplicationGroups.json
```

### Tag: package-2024-05-preview

These settings apply only when `--tag=package-2024-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-05-preview'
input-file:
- Microsoft.EventHub/preview/2024-05-01-preview/AvailableClusterRegions-preview.json
- Microsoft.EventHub/preview/2024-05-01-preview/Clusters-preview.json
- Microsoft.EventHub/preview/2024-05-01-preview/namespaces.json
- Microsoft.EventHub/preview/2024-05-01-preview/quotaConfiguration-preview.json
- Microsoft.EventHub/preview/2024-05-01-preview/networkrulessets-preview.json
- Microsoft.EventHub/preview/2024-05-01-preview/AuthorizationRules.json
- Microsoft.EventHub/preview/2024-05-01-preview/CheckNameAvailability.json
- Microsoft.EventHub/preview/2024-05-01-preview/consumergroups.json
- Microsoft.EventHub/preview/2024-05-01-preview/disasterRecoveryConfigs.json
- Microsoft.EventHub/preview/2024-05-01-preview/operations.json
- Microsoft.EventHub/preview/2024-05-01-preview/eventhubs.json
- Microsoft.EventHub/preview/2024-05-01-preview/SchemaRegistry.json
- Microsoft.EventHub/preview/2024-05-01-preview/ApplicationGroups.json
```

### Tag: package-2025-05-preview

These settings apply only when `--tag=package-2025-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-05-preview'
input-file:
- Microsoft.EventHub/preview/2025-05-01-preview/AvailableClusterRegions-preview.json
- Microsoft.EventHub/preview/2025-05-01-preview/Clusters-preview.json
- Microsoft.EventHub/preview/2025-05-01-preview/namespaces.json
- Microsoft.EventHub/preview/2025-05-01-preview/quotaConfiguration-preview.json
- Microsoft.EventHub/preview/2025-05-01-preview/networkrulessets-preview.json
- Microsoft.EventHub/preview/2025-05-01-preview/AuthorizationRules.json
- Microsoft.EventHub/preview/2025-05-01-preview/CheckNameAvailability.json
- Microsoft.EventHub/preview/2025-05-01-preview/consumergroups.json
- Microsoft.EventHub/preview/2025-05-01-preview/disasterRecoveryConfigs.json
- Microsoft.EventHub/preview/2025-05-01-preview/operations.json
- Microsoft.EventHub/preview/2025-05-01-preview/eventhubs.json
- Microsoft.EventHub/preview/2025-05-01-preview/SchemaRegistry.json
- Microsoft.EventHub/preview/2025-05-01-preview/ApplicationGroups.json
```

## Suppression

``` yaml
directive:
  - suppress: MissingTypeObject
    from: CheckNameAvailability.json
    reason: Not a mandatory check

  - suppress: ResourceNameRestriction
    from: consumergroups.json
    reason: Not a mandatory check
  - suppress: PutResponseCodes
    from: consumergroups.json
    reason: Not a mandatory check
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    from: consumergroups.json
    reason: Not a mandatory check
  - suppress: MissingTypeObject
    from: consumergroups.json
    reason: Not a mandatory check
  - suppress: TrackedResourcePatchOperation
    from: consumergroups.json
    reason: Not a mandatory check.
  - suppress: SystemDataDefinitionsCommonTypes
    from: consumergroups.json
    reason: Not a mandatory check
  
  - suppress: PathForResourceAction
    from: disasterRecoveryConfigs.json
    reason: Not a mandatory check
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    from: disasterRecoveryConfigs.json
    reason: Not a mandatory check
  - suppress: MissingTypeObject
    from: disasterRecoveryConfigs.json
    reason: Not a mandatory check
  - suppress: TrackedResourcePatchOperation
    from: disasterRecoveryConfigs.json
    reason: Not a mandatory check
  - suppress: ProvisioningStateValidation
    from: disasterRecoveryConfigs.json
    reason: Not a mandatory check
  - suppress: SystemDataDefinitionsCommonTypes
    from: disasterRecoveryConfigs.json
    reason: Not a mandatory check

  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    from: eventhubs.json
    reason: Not a mandatory check
  - suppress: ResourceNameRestriction
    from: eventhubs.json
    reason: Not a mandatory check
  - suppress: PutResponseCodes
    from: eventhubs.json
    reason: Not a mandatory check
  - suppress: MissingTypeObject
    from: eventhubs.json
    reason: Not a mandatory check

  - suppress: PostOperationAsyncResponseValidation
    from: namespaces-preview.json
    reason: Not a mandatory check
  - suppress: LroPostReturn
    from: namespaces-preview.json
    reason: Not a mandatory check
  - suppress: LroErrorContent
    from: namespaces.json
    reason: Suppress it for now to avoid breaking change because it is referenced by many files. 

  - suppress: LroLocationHeader
    from: Clusters-preview.json
    reason: Not a mandatory check
  - suppress: PutResponseCodes
    from: Clusters-preview.json
    reason: Not a mandatory check
  - suppress: LroErrorContent
    from: Clusters-preview.json
    reason: Not a mandatory check
  - suppress: PatchResponseCodes
    from: Clusters-preview.json
    reason: Not a mandatory check
  - suppress: PatchBodyParametersSchema
    from: Clusters-preview.json
    reason: Not a mandatory check
  - suppress: DeleteResponseCodes
    from: Clusters-preview.json
    reason: Not a mandatory check
  - suppress: XmsPageableForListCalls
    from: Clusters-preview.json
    reason: Not a mandatory check
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: Clusters-preview.json
    reason: Not a mandatory check
  - suppress: SystemDataDefinitionsCommonTypes
    from: Clusters-preview.json
    reason: Not a mandatory check
  - suppress: ResourceNameRestriction
    from: Clusters-preview.json
    reason: Not a mandatory check
  
  - suppress: ResourceNameRestriction
    from: namespaces.json
    reason: can't add ResourceNameRestriction at this time, as the current API version is old and introducing it could cause breaking changes.
  - suppress: ProvisioningStateMustBeReadOnly
    from: namespaces.json
    reason: Breaking change.
  - suppress: AllTrackedResourcesMustHaveDelete
    from: namespaces.json
    reason: Breaking Change.
  - suppress: TrackedResourcePatchOperation
    from: namespaces.json
    reason: Breaking change.
  - suppress: TrackedResourcesMustHavePut
    from: namespaces.json
    reason: Breaking change.

  - suppress: LroLocationHeader
    from: quotaConfiguration-preview.json
    reason: Not a mandatory check
  - suppress: LroExtension
    from: quotaConfiguration-preview.json
    reason: Not a mandatory check
  - suppress: PatchResponseCodes
    from: quotaConfiguration-preview.json
    reason: Not a mandatory check
  - suppress: XmsPageableForListCalls
    from: quotaConfiguration-preview.json
    reason: Not a mandatory check
  - suppress: BodyTopLevelProperties
    from: quotaConfiguration-preview.json
    reason: Not a mandatory check
  - suppress: NestedResourcesMustHaveListOperation
    from: quotaConfiguration-preview.json
    reason: Not a mandatory check
  - suppress: RequiredPropertiesMissingInResourceModel
    from: quotaConfiguration-preview.json
    reason: Not a mandatory check
  - suppress: AvoidAdditionalProperties
    from: quotaConfiguration-preview.json
    reason: Not a mandatory check
  - suppress: ResourceNameRestriction
    from: quotaConfiguration-preview.json
    reason: Not a mandatory check

  - suppress: OperationIdNounVerb
    from: AvailableClusterRegions-preview.json
    reason: Not a mandatory check
  - suppress: XmsPageableForListCalls
    from: AvailableClusterRegions-preview.json
    reason: Not a mandatory check
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: AvailableClusterRegions-preview.json
    reason: Not a mandatory check

  - suppress: OperationIdNounVerb
    from: ApplicationGroups.json
    reason: Not a mandatory check 
  - suppress: ResourceNameRestriction
    from: ApplicationGroups.json
    reason: Not a mandatory check
  - suppress: PutResponseCodes
    from: ApplicationGroups.json
    reason: Not a mandatory check
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    from: ApplicationGroups.json
    reason: Not a mandatory check
  - suppress: OperationIdNounVerb
    from: ApplicationGroups.json
    reason: Not a mandatory check
  - suppress: TrackedResourcePatchOperation
    from: ApplicationGroups.json
    reason: Not a mandatory check
  - suppress: SystemDataDefinitionsCommonTypes
    from: ApplicationGroups.json
    reason: Not a mandatory check

  - suppress: TrackedResourcePatchOperation
    from: networkrulessets-preview.json
    reason: Not a mandatory check
  - suppress: EvenSegmentedPathForPutOperation
    from: networkrulessets-preview.json
    reason: Not a mandatory check
  - suppress: PutResponseCodes
    from: networkrulessets-preview.json
    reason: Not a mandatory check
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    from: networkrulessets-preview.json
    reason: Not a mandatory check
  - suppress: XmsPageableForListCalls
    from: networkrulessets-preview.json
    reason: Not a mandatory check
  - suppress: MissingTypeObject
    from: networkrulessets-preview.json
    reason: Not a mandatory check
  - suppress: AllTrackedResourcesMustHaveDelete
    from: networkrulessets-preview.json
    reason: Not a mandatory check
  - suppress: TrackedResourcePatchOperation
    from: networkrulessets-preview.json
    reason: Not a mandatory check
  - suppress: SystemDataDefinitionsCommonTypes
    from: networkrulessets-preview.json
    reason: Not a mandatory check
  
  - suppress: ResourceNameRestriction
    from: AuthorizationRules.json
    reason: Not a mandatory check
  - suppress: PutResponseCodes
    from: AuthorizationRules.json
    reason: Not a mandatory check
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    from: AuthorizationRules.json
    reason: Not a mandatory check
  - suppress: MissingTypeObject
    from: AuthorizationRules.json
    reason: Not a mandatory check
  - suppress: SystemDataDefinitionsCommonTypes
    from: AuthorizationRules.json
    reason: Not a mandatory check
  - suppress: TrackedResourcePatchOperation
    from: AuthorizationRules.json
    reason: Not a mandatory check
```

### Tag: profile-hybrid-2020-09-01

These settings apply only when `--tag=profile-hybrid-2020-09-01` is specified on the command line.

``` yaml $(tag) == 'profile-hybrid-2020-09-01'
input-file:
- Microsoft.EventHub/preview/2018-01-01-preview/AvailableClusterRegions-preview.json
- Microsoft.EventHub/preview/2018-01-01-preview/Clusters-preview.json
- Microsoft.EventHub/preview/2018-01-01-preview/namespaces-preview.json
- Microsoft.EventHub/stable/2017-04-01/AuthorizationRules.json
- Microsoft.EventHub/stable/2017-04-01/CheckNameAvailability.json
- Microsoft.EventHub/stable/2017-04-01/consumergroups.json
- Microsoft.EventHub/stable/2017-04-01/operations.json
- Microsoft.EventHub/stable/2017-04-01/eventhubs.json
- Microsoft.EventHub/stable/2017-04-01/sku.json
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
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_event_hub']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```


## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)



