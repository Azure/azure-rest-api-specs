# HybridCompute

> see https://aka.ms/autorest

This is the AutoRest configuration file for HybridCompute RP.

---

## Getting Started

To build the SDK for HybridCompute, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the HybridCompute API.

``` yaml
openapi-type: arm
tag: package-preview-2024-03
directive:
  - from: HybridCompute.json
    where: $.definitions.MachineInstallPatchesParameters.properties.maximumDuration
    transform: '$[''format''] = ''duration'''
  - from: HybridCompute.json
    where: $.definitions.MachineUpdateProperties.properties.privateLinkScopeResourceId
    transform: '$[''format''] = ''arm-id'''
  - from: HybridCompute.json
    where: $.definitions.MachineProperties.properties.privateLinkScopeResourceId
    transform: '$[''format''] = ''arm-id'''
  - from: HybridCompute.json
    where: $.definitions.AgentUpgrade.properties.correlationId
    transform: '$[''format''] = ''uuid'''
  - from: HybridCompute.json
    where: $.definitions.AgentUpgrade.properties.lastAttemptTimestamp
    transform: '$[''format''] = ''date-time'''
  - from: HybridCompute.json
    where: $.definitions.MachineProperties.properties.vmUuid
    transform: '$[''format''] = ''uuid'''
  - from: HybridCompute.json
    where: $.definitions.MachineProperties.properties.vmId
    transform: '$[''format''] = ''uuid'''
  - from: HybridCompute.json
    where: $.definitions.MachineUpdateProperties.properties.parentClusterResourceId
    transform: '$[''format''] = ''arm-id'''
  - from: HybridCompute.json
    where: $.definitions.MachineProperties.properties.parentClusterResourceId
    transform: '$[''format''] = ''arm-id'''
  - from: HybridCompute.json
    where: $.definitions.MachineAssessPatchesResult.properties.assessmentActivityId
    transform: '$[''format''] = ''uuid'''
  - from: HybridCompute.json
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}"].get.parameters'
    transform: |-
      return [
          {
            "$ref": "../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParameter"
          },
          {
            "$ref": "../../../../../common-types/resource-management/v3/types.json#/parameters/SubscriptionIdParameter"
          },
          {
            "$ref": "../../../../../common-types/resource-management/v3/types.json#/parameters/ResourceGroupNameParameter"
          },
          {
            "name": "machineName",
            "in": "path",
            "required": true,
            "type": "string",
            "pattern": "^[a-zA-Z0-9-_\\.]{1,54}$",
            "minLength": 1,
            "maxLength": 54,
            "description": "The name of the hybrid machine."
          },
          {
            "name": "$expand",
            "in": "query",
            "required": false,
            "type": "string",
            "description": "The expand expression to apply on the operation.",
          }
        ]
  - from: HybridCompute.json
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/runCommands/{runCommandName}"].delete.responses'
    transform: |-
      return {
        "200": {
          "description": "OK"
        },
        "202": {
          "description": "Accepted",
          "headers": {
            "Location": {
              "description": "The URL of the resource used to check the status of the asynchronous operation.",
              "type": "string"
            },
            "Retry-After": {
              "description": "The recommended number of seconds to wait before calling the URI specified in Azure-AsyncOperation.",
              "type": "integer",
              "format": "int32"
            },
            "Azure-AsyncOperation": {
              "description": "The URI to poll for completion status.",
              "type": "string"
            }
          }
        },
        "204": {
          "description": "No Content"
        },
        "default": {
          "description": "Error response describing why the operation failed.",
          "schema": {
            "$ref": "../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse"
          }
        }
      }
  - where:
      subject: NetworkProfile
    remove: true
  - where:
      subject: MachineRunCommand
      verb: Set
    remove: true
  - remove-operation: Machines_CreateOrUpdate
  - remove-operation: MachineRunCommands_Update
  - remove-operation: AgentVersion_List
  - remove-operation: AgentVersion_Get
  - remove-operation: HybridIdentityMetadata_Get
  - remove-operation: HybridIdentityMetadata_ListByMachines
  - remove-operation: Licenses_Get
  - remove-operation: Licenses_ValidateLicense
  - remove-operation: Licenses_ListBySubscription
  - remove-operation: Licenses_ListByResourceGroup
  - remove-operation: Licenses_Delete
  - remove-operation: Licenses_Update
  - remove-operation: Licenses_CreateOrUpdate
  - remove-operation: LicenseProfiles_Get
  - remove-operation: LicenseProfiles_Delete
  - remove-operation: LicenseProfiles_Update
  - remove-operation: LicenseProfiles_List
  - remove-operation: LicenseProfiles_CreateOrUpdate
  - remove-operation: NetworkConfigurations_Get
  - remove-operation: NetworkConfigurations_Update
  - remove-operation: NetworkConfigurations_CreateOrUpdate
  - remove-operation: NetworkSecurityPerimeterConfigurations_GetByPrivateLinkScope
  - remove-operation: NetworkSecurityPerimeterConfigurations_ListByPrivateLinkScope
  - remove-operation: NetworkSecurityPerimeterConfigurations_ReconcileForPrivateLinkScope
```


### Tag: package-preview-2024-03

These settings apply only when `--tag=package-preview-2024-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-03'
input-file:
  - Microsoft.HybridCompute/preview/2024-03-31-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2024-03-31-preview/privateLinkScopes.json
```
### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-10'
input-file:
  - Microsoft.HybridCompute/preview/2023-10-03-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2023-10-03-preview/privateLinkScopes.json
```

### Tag: package-preview-2023-06

These settings apply only when `--tag=package-preview-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-06'
input-file:
  - Microsoft.HybridCompute/preview/2023-06-20-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2023-06-20-preview/privateLinkScopes.json
```

### Tag: package-preview-2023-03

These settings apply only when `--tag=package-preview-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-03'
input-file:
  - Microsoft.HybridCompute/preview/2023-03-15-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2023-03-15-preview/privateLinkScopes.json
```

### Tag: package-2022-12

These settings apply only when `--tag=package-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-2022-12'
input-file:
  - Microsoft.HybridCompute/stable/2022-12-27/HybridCompute.json
  - Microsoft.HybridCompute/stable/2022-12-27/privateLinkScopes.json
```

### Tag: package-preview-2022-12

These settings apply only when `--tag=package-preview-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-12'
input-file:
  - Microsoft.HybridCompute/preview/2022-12-27-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2022-12-27-preview/privateLinkScopes.json
```

### Tag: package-2022-11

These settings apply only when `--tag=package-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-2022-11'
input-file:
  - Microsoft.HybridCompute/stable/2022-11-10/HybridCompute.json
  - Microsoft.HybridCompute/stable/2022-11-10/privateLinkScopes.json
```

### Tag: package-preview-2022-08

These settings apply only when `--tag=package-preview-2022-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-08'
input-file:
  - Microsoft.HybridCompute/preview/2022-08-11-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2022-08-11-preview/privateLinkScopes.json
```

### Tag: package-preview-2022-05

These settings apply only when `--tag=package-preview-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-05'
input-file:
  - Microsoft.HybridCompute/preview/2022-05-10-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2022-05-10-preview/privateLinkScopes.json
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-2022-03'
input-file:
  - Microsoft.HybridCompute/stable/2022-03-10/HybridCompute.json
  - Microsoft.HybridCompute/stable/2022-03-10/privateLinkScopes.json
```

### Tag: package-preview-2021-12

These settings apply only when `--tag=package-preview-2021-12` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-12'
input-file:
  - Microsoft.HybridCompute/preview/2021-12-10-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2021-12-10-preview/privateLinkScopes.json
```

### Tag: package-preview-2021-06

These settings apply only when `--tag=package-preview-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-06'
input-file:
  - Microsoft.HybridCompute/preview/2021-06-10-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2021-06-10-preview/privateLinkScopes.json
```

### Tag: package-preview-2021-05

These settings apply only when `--tag=package-preview-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-05'
input-file:
  - Microsoft.HybridCompute/preview/2021-05-17-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2021-05-17-preview/privateLinkScopes.json
```

### Tag: package-2021-05

These settings apply only when `--tag=package-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-2021-05'
input-file:
  - Microsoft.HybridCompute/stable/2021-05-20/HybridCompute.json
  - Microsoft.HybridCompute/stable/2021-05-20/privateLinkScopes.json
```

### Tag: package-preview-2021-04

These settings apply only when `--tag=package-preview-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-04'
input-file:
  - Microsoft.HybridCompute/preview/2021-04-22-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2021-04-22-preview/privateLinkScopes.json
```

### Tag: package-preview-2021-03

These settings apply only when `--tag=package-preview-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-03'
input-file:
  - Microsoft.HybridCompute/preview/2021-03-25-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2021-03-25-preview/privateLinkScopes.json
```

### Tag: package-preview-2021-01

These settings apply only when `--tag=package-preview-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-01'
input-file:
- Microsoft.HybridCompute/preview/2021-01-28-preview/HybridCompute.json
- Microsoft.HybridCompute/preview/2021-01-28-preview/privateLinkScopes.json
```

### Tag: package-preview-2020-08

These settings apply only when `--tag=package-preview-2020-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-08'
input-file:
- Microsoft.HybridCompute/preview/2020-08-15-preview/HybridCompute.json
- Microsoft.HybridCompute/preview/2020-08-15-preview/privateLinkScopes.json
```

### Tag: package-2019-03

These settings apply only when `--tag=package-2019-03` is specified on the command line.

``` yaml $(tag) == 'package-2019-03'
input-file:
- Microsoft.HybridCompute/preview/2019-03-18/HybridCompute.json
```

### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` is specified on the command line.

``` yaml $(tag) == 'package-2019-08'
input-file:
- Microsoft.HybridCompute/preview/2019-08-02/HybridCompute.json
```

### Tag: package-2019-12

These settings apply only when `--tag=package-2019-12` is specified on the command line.

``` yaml $(tag) == 'package-2019-12'
input-file:
- Microsoft.HybridCompute/stable/2019-12-12/HybridCompute.json
```

### Tag: package-2020-07-30-preview

These settings apply only when `--tag=package-2020-07-30-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-07-30-preview'
input-file:
- Microsoft.HybridCompute/preview/2020-07-30-preview/HybridCompute.json
```

### Tag: package-2020-08-02

These settings apply only when `--tag=package-2020-08-02` is specified on the command line.

``` yaml $(tag) == 'package-2020-08-02'
input-file:
- Microsoft.HybridCompute/stable/2020-08-02/HybridCompute.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

---

## az CLI

See configuration in [readme.az.md](./readme.az.md) and [readme.cli.md](./readme.cli.md)

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## PowerShell

See configuration in the [Azure PowerShell repo](https://github.com/Azure/azure-powershell/tree/generation/src/ConnectedMachine)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript](./readme.typescript.md)
