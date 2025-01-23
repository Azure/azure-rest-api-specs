# MonitorClient

> see https://aka.ms/autorest

This is the AutoRest configuration file for MonitorClient.

---

## Getting Started

To build the SDK for MonitorClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the MonitorClient API.

```yaml !$(python) || !$(track2)
title: MonitorClient
```

```yaml
description: Monitor Management Client
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2021-09-01
```

### Tag: package-2023-06-01-preview

These settings apply only when `--tag=package-2023-06-01-preview` is specified on the command line

``` yaml $(tag) == 'package-2023-06-01-preview'
input-file:
- preview\2023-06-01-preview\privateLinkScopes_API.json
```

### Tag: package-2021-09-01

These settings apply only when `--tag=package-2021-09-01` is specified on the command line

``` yaml $(tag) == 'package-2021-09-01'
input-file:
- stable\2021-09-01\privateLinkScopes_API.json
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

# Validation

## Suppression

```yaml
directive:
  - suppress: R4009
    from: privateLinkScopes_API.json
    reason: "Contract is defined in the Network RP private endpoint spec, can be updated by internal calls from Network RP. "
  - suppress: R3018
    from: privateLinkScopes_API.json
    where: $.definitions.PrivateEndpointConnectionProperties.properties.queryOnlyPrivateLinkResources
    reason: "This property indicates whether data coming through this private endpoint should restrict itself only to resources in the scope - it has only ''true'' or ''false'' options, so it fits boolean type."
  - suppress: R3018
    from: privateLinkScopes_API.json
    where: $.definitions.PrivateEndpointConnectionProperties.properties.ingestOnlyToPrivateLinkResources
    reason: "This property indicates whether data coming through this private endpoint should restrict itself only to resources in the scope - it has only ''true'' or ''false'' options, so it fits boolean type."
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: privateLinkScopes_API.json
    reason: "Updating the model would be a breaking change."
  - suppress: XmsPageableForListCalls
    from: privateLinkScopes_API.json
    reason: "List scoped resources does not support pagination"
  - suppress: ProvisioningStateSpecifiedForLROPut
    from: privateLinkScopes_API.json
    reason: "This was based on older guidance for structuring long-running operations. Changing the contract would be a breaking change."
  - suppress: PutResponseCodes
    from: privateLinkScopes_API.json
    reason: "This was based on older guidance for structuring long-running operations. Changing the contract would be a breaking change."
  - suppress: DeleteResponseCodes
    from: privateLinkScopes_API.json
    reason: "This was based on older guidance for structuring long-running operations. Changing the contract would be a breaking change."
  - suppress: BodyTopLevelProperties
    from: privateLinkScopes_API.json
    reason: "This was based on older guidance for structuring long-running operations. Changing the contract would be a breaking change."
  - suppress: OperationsAPIImplementation
    where: $.paths
    from: privateLinkScopes_API.json
    reason: 'Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)'
  - suppress: ResourceNameRestriction
    from: privateLinkScopes_API.json
    reason: 'Updating the resource name restriction would be a breaking change.'
  - suppress: OperationsAPIImplementation
    from: privateLinkScopes_API.json
    reason: 'Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)'