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
