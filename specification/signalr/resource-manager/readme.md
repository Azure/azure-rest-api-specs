# SignalR

> see https://aka.ms/autorest

This is the AutoRest configuration file for SignalR.



---
## Getting Started
To build the SDK for SignalR, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the SignalR API.

``` yaml
openapi-type: arm
tag: package-2023-08-01-preview
```

### Suppression

``` yaml
directive:
  - suppress: EnumInsteadOfBoolean
    from: signalr.json
    where:
    - $.definitions.NameAvailability.properties.nameAvailable
    - $.definitions.Dimension.properties.toBeExportedForShoebox
    - $.definitions.Operation.properties.isDataAction
    - $.definitions.SignalRTlsSettings.properties.clientCertEnabled
    - $.definitions.SignalRProperties.properties.disableLocalAuth
    - $.definitions.SignalRProperties.properties.disableAadAuth
    reason:  The boolean properties 'nameAvailable' and 'isDataAction' is standard property defined by Azure API spec. 'toBeExportedForShoebox' by Geneva metrics team. Keep 'clientCertEnabled' bool to be consistent with SignalR and not break existing customers. 'disableLocalAuth' and 'disableAadAuth' by Identity team.
  - suppress: TrackedResourceListByImmediateParent
    reason: Another list APIs naming approach is used over the specs
  - suppress: AvoidNestedProperties
    from: signalr.json
    where:
    - $.definitions.SignalRFeature.properties.properties
    - $.definitions.PrivateEndpointConnection.properties.properties
    - $.definitions.ShareablePrivateLinkResourceType.properties.properties
    reason:  The 'properties' is a user-defined dictionary, cannot be flattened.
  - suppress: PutInOperationName
    where:
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.operationId
    reason: It's indeed an UPDATE operation, but PUT is required per NRP requirement.
  - suppress: InvalidSkuModel
    where:
    - $.definitions.Sku
    reason: It's required by spec of enumerating SKUs for an existing resource
  - suppress: ParametersOrder
    where:
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}"].get
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}"].put
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}"].delete
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}"].get
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}"].put
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}"].delete
    reason: It can introduce a breaking change when updating parameter order, since SignalR service has already shipped public versions.
```

### Tag: package-2023-08-01-preview

These settings apply only when `--tag=package-2023-08-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-08-01-preview'
input-file:
- Microsoft.SignalRService/preview/2023-08-01-preview/signalr.json
```

### Tag: package-2023-06-01-preview

These settings apply only when `--tag=package-2023-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-06-01-preview'
input-file:
- Microsoft.SignalRService/preview/2023-06-01-preview/signalr.json
```

### Tag: package-2023-03-01-preview

These settings apply only when `--tag=package-2023-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-03-01-preview'
input-file:
- Microsoft.SignalRService/preview/2023-03-01-preview/signalr.json
```

### Tag: package-2023-02-01

These settings apply only when `--tag=package-2023-02-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-02-01'
input-file:
- Microsoft.SignalRService/stable/2023-02-01/signalr.json
```

### Tag: package-2022-08-01-preview

These settings apply only when `--tag=package-2022-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-08-01-preview'
input-file:
- Microsoft.SignalRService/preview/2022-08-01-preview/signalr.json
```

### Tag: package-2022-02-01

These settings apply only when `--tag=package-2022-02-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-02-01'
input-file:
- Microsoft.SignalRService/stable/2022-02-01/signalr.json
```

### Tag: package-2021-09-01-preview

These settings apply only when `--tag=package-2021-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-09-01-preview'
input-file:
- Microsoft.SignalRService/preview/2021-09-01-preview/signalr.json
```

### Tag: package-2021-10-01

These settings apply only when `--tag=package-2021-10-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-10-01'
input-file:
- Microsoft.SignalRService/stable/2021-10-01/signalr.json
```

### Tag: package-2021-06-01-preview

These settings apply only when `--tag=package-2021-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-01-preview'
input-file:
- Microsoft.SignalRService/preview/2021-06-01-preview/signalr.json
```

### Tag: package-2021-04-01-preview

These settings apply only when `--tag=package-2021-04-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-04-01-preview'
input-file:
- Microsoft.SignalRService/preview/2021-04-01-preview/signalr.json
```

### Tag: package-2020-07-01-preview

These settings apply only when `--tag=package-2020-07-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-07-01-preview'
input-file:
- Microsoft.SignalRService/preview/2020-07-01-preview/signalr.json
```

### Tag: package-2020-05-01

These settings apply only when `--tag=package-2020-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-05-01'
input-file:
- Microsoft.SignalRService/stable/2020-05-01/signalr.json
```

### Tag: package-2018-10-01

These settings apply only when `--tag=package-2018-10-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-10-01'
input-file:
- Microsoft.SignalRService/stable/2018-10-01/signalr.json
```

### Tag: package-2018-03-01-preview

These settings apply only when `--tag=package-2018-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-01-preview'
input-file:
- Microsoft.SignalRService/preview/2018-03-01-preview/signalr.json
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_signalr']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated with AutoRest.0.17.3
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.SignalR
  output-folder: $(csharp-sdks-folder)/signalr/Microsoft.Azure.Management.SignalR/src/Generated
  clear-output-folder: true
```



