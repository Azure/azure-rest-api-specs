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
  - suppress: ResourceNameRestriction
    reason: Adding name patterns to inherited Relay resources would tighten the accepted names compared with the 2026-01-01 contract; the new cluster name uses the service-enforced pattern.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/regenerateKeys"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}/listKeys"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}/regenerateKeys"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/networkRuleSets/default"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateLinkResources"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateLinkResources/{privateLinkResourceName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}/listKeys"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}/regenerateKeys"]
  - suppress: ProvisioningStateMustBeReadOnly
    reason: The TypeSpec properties are read-only, but the legacy validator ignores readOnly beside a $ref. The project-wide emitter workaround cannot be used because it changes shipped stable Relay schemas.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}"].get.responses.200.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}"].put.responses.200.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}"].put.responses.201.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}"].patch.responses.200.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}"].get.responses.200.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.responses.200.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.responses.201.schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.responses.202.schema
  - suppress: PutResponseCodes
    reason: These responses match the implemented Relay contract for inherited resources that cannot be changed without breaking existing clients.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/networkRuleSets/default"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}"].put
  - suppress: PatchResponseCodes
    reason: The inherited namespace PATCH response codes are part of the existing Relay service contract and changing them would be breaking; the new cluster PATCH emits only 200.
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}"].patch
  - suppress: DeleteResponseCodes
    reason: These responses match the implemented Relay contract for inherited resources that cannot be changed without breaking clients.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}"].delete
  - suppress: GetResponseCodes
    reason: The inherited GET response codes are part of the existing Relay service contract and changing them would be breaking.
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}"].get
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    reason: Adding tags to inherited request schemas would change the existing Relay API contract.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules/{authorizationRuleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}"].put
  - suppress: TrackedResourcePatchOperation
    reason: The affected inherited resource types do not support additional PATCH operations in the Relay service.
    where:
      - $.definitions.AuthorizationRule
      - $.definitions.HybridConnection
      - $.definitions.PrivateEndpointConnection
      - $.definitions.WcfRelay
  - suppress: XMSSecretInResponse
    reason: Adding x-ms-secret to the inherited access-key response would change the generated SDK surface.
    where:
      - $.definitions.AccessKeys.properties.primaryKey
      - $.definitions.AccessKeys.properties.secondaryKey
  - suppress: XmsPageableForListCalls
    reason: The inherited private-link list does not implement continuation tokens; emitting x-ms-pageable would describe unsupported service behavior.
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateLinkResources"].get
  - suppress: PageableOperation
    reason: These Relay endpoints return their complete collections in one response and implement no continuation mechanism.
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Relay/availableClusterRegions"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}/namespaces"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}/skus"].get
  - suppress: XmsPageableForListCalls
    reason: These Relay endpoints do not support continuation tokens, so emitting x-ms-pageable would advertise unsupported service behavior.
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Relay/availableClusterRegions"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}/namespaces"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}/skus"].get
  - suppress: GetCollectionOnlyHasValueAndNextLink
    reason: These Relay endpoints return complete non-paged collections and the service does not implement a nextLink continuation mechanism.
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Relay/availableClusterRegions"].get.responses.200.schema.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}/namespaces"].get.responses.200.schema.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/clusters/{clusterName}/skus"].get.responses.200.schema.properties
  - suppress: NestedResourcesMustHaveListOperation
    reason: NetworkRuleSet is an inherited singleton child resource and the Relay service does not expose a list operation for it.
    where: $.definitions.NetworkRuleSet
  - suppress: LroLocationHeader
    reason: The inherited long-running response headers are part of the existing Relay service contract.
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.responses.202
  - suppress: LroExtension
    reason: The inherited long-running operation metadata is part of the existing Relay service contract.
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put
  - suppress: OperationIdNounVerb
    reason: Clusters_ListAvailableClusterRegion matches the established Event Hubs cluster operation name and keeps the corresponding Relay and Event Hubs SDK surfaces consistent.
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Relay/availableClusterRegions"].get.operationId
  - suppress: RequiredPropertiesMissingInResourceModel
    reason: >
      These collection responses (AvailableRelayClustersList, RelayClusterSkuListResult, RelayNamespaceIdListResult) return catalog or reference data rather than lifecycle-managed ARM resources.
      AvailableRelayClustersList returns region availability information (utility/discovery data).
      RelayClusterSkuListResult returns SKU capability information (catalog data).
      RelayNamespaceIdListResult returns lightweight references to existing Microsoft.Relay/namespaces resources that are fully managed through their own CRUD operations.
      These endpoints intentionally use simplified data models without full ARM proxy resource patterns (no point GET operations) because they provide read-only utility information rather than independent resource lifecycle management.
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
