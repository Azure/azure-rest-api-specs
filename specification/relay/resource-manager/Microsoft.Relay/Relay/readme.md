# Relay

> see https://aka.ms/autorest

This is the AutoRest configuration file for Relay.



---
## Getting Started
To build the SDK for Relay, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration


### Basic Information
These are the global settings for the Relay API.

``` yaml
openapi-type: arm
tag: package-2026-01
```

### Tag: package-2021-11-01

These settings apply only when `--tag=package-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-2021-11'
input-file:
- stable/2021-11-01/authorizationRules.json
- stable/2021-11-01/hybridConnections.json
- stable/2021-11-01/Namespaces.json
- stable/2021-11-01/NetworkRuleSets.json
- stable/2021-11-01/operations.json
- stable/2021-11-01/wcfRelays.json
```

### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

``` yaml $(tag) == 'package-2017-04'
input-file:
- stable/2017-04-01/relay.json
```


### Tag: package-2016-07

These settings apply only when `--tag=package-2016-07` is specified on the command line.

``` yaml $(tag) == 'package-2016-07'
input-file:
- stable/2016-07-01/relay.json
```


### Tag: package-2018-01-preview

These settings apply only when `--tag=package-2018-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-preview'
input-file:
- preview/2018-01-01-preview/Namespaces-preview.json
- preview/2018-01-01-preview/NetworkRuleSets-preview.json
- preview/2018-01-01-preview/PrivateEndpointConnection-preview.json
- preview/2018-01-01-preview/PrivateLinkResources-preview.json
```

### Tag: package-2024-01-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-01'
input-file:
- stable/2024-01-01/relay.json
```

### Tag: package-2026-01

These settings apply only when `--tag=package-2026-01` is specified on the command line.

``` yaml $(tag) == 'package-2026-01'
input-file:
- stable/2026-01-01/relay.json
directive:
  - suppress: LatestVersionOfCommonTypesMustBeUsed
    reason: This stable version carries forward the 2024-01-01 Relay contract, which emits ARM common-types v3. Moving the service to v6 would change inherited schemas outside the scope of the minimum TLS version feature.
  - suppress: ResourceNameRestriction
    reason: Adding name patterns would tighten the accepted resource names compared with the existing 2024-01-01 contract.
  - suppress: PutResponseCodes
    reason: The PUT response codes are inherited from the existing Relay service contract; changing them would be a breaking API change.
  - suppress: PatchResponseCodes
    reason: The PATCH response codes are inherited from the existing Relay service contract; changing them would be a breaking API change.
  - suppress: DeleteResponseCodes
    reason: The DELETE response codes are inherited from the existing Relay service contract; changing them would be a breaking API change.
  - suppress: GetResponseCodes
    reason: The GET response codes are inherited from the existing Relay service contract; changing them would be a breaking API change.
  - suppress: AvoidMsdnReferences
    reason: The external documentation links are inherited from 2024-01-01 and are unrelated to the minimum TLS version API change.
  - suppress: EnumInsteadOfBoolean
    reason: The boolean properties are inherited from the existing contract; changing their wire types to enums would be breaking.
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    reason: Adding tags to these inherited request schemas would change the existing Relay API contract.
  - suppress: LocationMustHaveXmsMutability
    reason: The location mutability is inherited from the existing generated contract and changing it could alter generated client behavior.
  - suppress: TrackedResourcePatchOperation
    reason: The affected inherited resource types do not support additional PATCH operations in the Relay service.
  - suppress: ProvisioningStateMustBeReadOnly
    reason: The reported provisioning-state shapes are inherited from the existing generated contract and are outside this feature's scope.
  - suppress: XMSSecretInResponse
    reason: Adding x-ms-secret to the inherited access-key response would change the generated SDK surface shared with 2024-01-01.
  - suppress: SchemaDescriptionOrTitle
    reason: The schema shape is inherited from the existing generated contract and is unrelated to the minimum TLS version feature.
  - suppress: PageableOperation
    reason: Adding paging metadata would change the generated SDK surface for an inherited list operation.
  - suppress: XmsPageableForListCalls
    reason: Adding paging metadata would change the generated SDK surface for an inherited list operation.
  - suppress: NestedResourcesMustHaveListOperation
    reason: NetworkRuleSet is an inherited singleton child resource and the Relay service does not expose a list operation for it.
  - suppress: LroLocationHeader
    reason: The long-running response headers are inherited from the existing Relay service contract; changing them would be breaking.
  - suppress: LroExtension
    reason: The long-running operation metadata is inherited from the existing Relay service contract; changing it could alter client behavior.
  - suppress: AllProxyResourcesShouldHaveDelete
    reason: NetworkRuleSet is an inherited singleton child resource and the Relay service does not expose a delete operation for it.
```

### Tag: package-2026-07-preview

These settings apply only when `--tag=package-2026-07-preview` is specified on the command line.

``` yaml $(tag) == 'package-2026-07-preview'
input-file:
- preview/2026-07-01-preview/relay.json
directive:
  - suppress: LatestVersionOfCommonTypesMustBeUsed
    reason: This preview carries forward the 2026-01-01 Relay contract, which emits ARM common-types v3. Moving inherited resources to v6 would change schemas outside the scope of the Relay cluster feature.
  - suppress: ResourceNameRestriction
    reason: Adding name patterns to inherited Relay resources would tighten the accepted names compared with the 2026-01-01 contract.
  - suppress: PutResponseCodes
    reason: The inherited PUT response codes are part of the existing Relay service contract and changing them would be breaking.
  - suppress: PatchResponseCodes
    reason: The inherited PATCH response codes are part of the existing Relay service contract and changing them would be breaking.
  - suppress: DeleteResponseCodes
    reason: The inherited DELETE response codes are part of the existing Relay service contract and changing them would be breaking.
  - suppress: GetResponseCodes
    reason: The inherited GET response codes are part of the existing Relay service contract and changing them would be breaking.
  - suppress: AvoidMsdnReferences
    reason: The external documentation links are inherited from 2026-01-01 and are unrelated to the Relay cluster feature.
  - suppress: EnumInsteadOfBoolean
    reason: The inherited boolean properties are part of the existing Relay contract and changing their wire types would be breaking.
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    reason: Adding tags to inherited request schemas would change the existing Relay API contract.
  - suppress: LocationMustHaveXmsMutability
    reason: The inherited location mutability is part of the existing generated contract and changing it could alter generated client behavior.
  - suppress: TrackedResourcePatchOperation
    reason: The affected inherited resource types do not support additional PATCH operations in the Relay service.
  - suppress: ProvisioningStateMustBeReadOnly
    reason: The inherited provisioning-state shapes are outside the scope of the Relay cluster feature.
  - suppress: XMSSecretInResponse
    reason: Adding x-ms-secret to the inherited access-key response would change the generated SDK surface.
  - suppress: SchemaDescriptionOrTitle
    reason: The inherited schema shape is unrelated to the Relay cluster feature.
  - suppress: PageableOperation
    reason: Adding paging metadata would change the generated SDK surface for an inherited list operation.
  - suppress: XmsPageableForListCalls
    reason: Adding paging metadata would change the generated SDK surface for an inherited list operation.
  - suppress: NestedResourcesMustHaveListOperation
    reason: NetworkRuleSet is an inherited singleton child resource and the Relay service does not expose a list operation for it.
  - suppress: LroLocationHeader
    reason: The inherited long-running response headers are part of the existing Relay service contract.
  - suppress: LroExtension
    reason: The inherited long-running operation metadata is part of the existing Relay service contract.
  - suppress: AllProxyResourcesShouldHaveDelete
    reason: NetworkRuleSet is an inherited singleton child resource and the Relay service does not expose a delete operation for it.
  - suppress: OperationIdNounVerb
    reason: Clusters_ListAvailableClusterRegion matches the established Event Hubs cluster operation name and keeps the corresponding Relay and Event Hubs SDK surfaces consistent.
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Relay/availableClusterRegions"].get.operationId
  - suppress: GetCollectionOnlyHasValueAndNextLink
    reason: These operations return collections of region, SKU, or resource-ID values rather than collections of ARM resources, so the ARM resource-list envelope rule does not apply.
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Relay/availableClusterRegions"].get.responses.200.schema.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}/skus"].get.responses.200.schema.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}/namespaces"].get.responses.200.schema.properties
  - suppress: ParametersInPointGet
    reason: This is the implemented Relay long-running operation status endpoint, not a resource point GET; the query parameters identify the cluster operation being polled.
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Relay/locations/{location}/clusterOperationResults/{operationId}"].get.parameters
  - suppress: ParameterNotUsingCommonTypes
    reason: resourceGroupName is a query parameter required by the Relay operation coordinator rather than the ARM resource-group path parameter defined by common types.
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Relay/locations/{location}/clusterOperationResults/{operationId}"].get.parameters[7].name
  - suppress: RequiredPropertiesMissingInResourceModel
    reason: These definitions are non-resource list response wrappers whose names trigger the resource-model heuristic; their items are regions, SKU descriptions, or namespace resource IDs.
    where:
      - $.definitions.AvailableRelayClustersList
      - $.definitions.RelayClusterSkuListResult
      - $.definitions.RelayNamespaceIdListResult
  - suppress: PatchBodyParametersSchema
    reason: The inherited namespace PATCH request carries forward the 2026-01-01 wire contract, including its name and publicNetworkAccess schema behavior.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}"].patch.parameters[4].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}"].patch.parameters[4].schema.properties.sku
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
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_relay']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```


## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
