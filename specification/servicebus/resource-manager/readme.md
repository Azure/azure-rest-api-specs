# ServiceBus

> see https://aka.ms/autorest

This is the AutoRest configuration file for ServiceBus.



---
## Getting Started
To build the SDK for ServiceBus, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help` 
---

## Configuration



### Basic Information
These are the global settings for the ServiceBus API.

``` yaml
openapi-type: arm
tag: package-2024-01
```

### Tag: package-2021-01-preview

These settings apply only when `--tag=package-2021-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-preview'
input-file:
- Microsoft.ServiceBus/preview/2021-01-01-preview/namespace-preview.json
- Microsoft.ServiceBus/preview/2021-01-01-preview/operations.json
- Microsoft.ServiceBus/preview/2021-01-01-preview/DisasterRecoveryConfig.json
- Microsoft.ServiceBus/preview/2021-01-01-preview/migrationconfigs.json
- Microsoft.ServiceBus/preview/2021-01-01-preview/networksets.json
- Microsoft.ServiceBus/preview/2021-01-01-preview/AuthorizationRules.json
- Microsoft.ServiceBus/preview/2021-01-01-preview/Queue.json
- Microsoft.ServiceBus/preview/2021-01-01-preview/topics.json
- Microsoft.ServiceBus/preview/2021-01-01-preview/Rules.json
- Microsoft.ServiceBus/preview/2021-01-01-preview/subscriptions.json
- Microsoft.ServiceBus/preview/2021-01-01-preview/CheckNameAvailability.json
```

### Tag: package-2021-06-preview

These settings apply only when `--tag=package-2021-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-preview'
input-file:
- Microsoft.ServiceBus/preview/2021-06-01-preview/namespace-preview.json
- Microsoft.ServiceBus/preview/2021-06-01-preview/operations.json
- Microsoft.ServiceBus/preview/2021-06-01-preview/DisasterRecoveryConfig.json
- Microsoft.ServiceBus/preview/2021-06-01-preview/migrationconfigs.json
- Microsoft.ServiceBus/preview/2021-06-01-preview/networksets.json
- Microsoft.ServiceBus/preview/2021-06-01-preview/AuthorizationRules.json
- Microsoft.ServiceBus/preview/2021-06-01-preview/Queue.json
- Microsoft.ServiceBus/preview/2021-06-01-preview/topics.json
- Microsoft.ServiceBus/preview/2021-06-01-preview/Rules.json
- Microsoft.ServiceBus/preview/2021-06-01-preview/subscriptions.json
- Microsoft.ServiceBus/preview/2021-06-01-preview/CheckNameAvailability.json
```

### Tag: package-2022-01-preview

These settings apply only when `--tag=package-2022-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-01-preview'
input-file:
- Microsoft.ServiceBus/preview/2022-01-01-preview/namespace-preview.json
- Microsoft.ServiceBus/preview/2022-01-01-preview/operations.json
- Microsoft.ServiceBus/preview/2022-01-01-preview/DisasterRecoveryConfig.json
- Microsoft.ServiceBus/preview/2022-01-01-preview/migrationconfigs.json
- Microsoft.ServiceBus/preview/2022-01-01-preview/networksets.json
- Microsoft.ServiceBus/preview/2022-01-01-preview/AuthorizationRules.json
- Microsoft.ServiceBus/preview/2022-01-01-preview/Queue.json
- Microsoft.ServiceBus/preview/2022-01-01-preview/topics.json
- Microsoft.ServiceBus/preview/2022-01-01-preview/Rules.json
- Microsoft.ServiceBus/preview/2022-01-01-preview/subscriptions.json
- Microsoft.ServiceBus/preview/2022-01-01-preview/CheckNameAvailability.json
```

### Tag: package-2022-10-preview

These settings apply only when `--tag=package-2022-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-10-preview'
input-file:
- Microsoft.ServiceBus/preview/2022-10-01-preview/namespace-preview.json
- Microsoft.ServiceBus/preview/2022-10-01-preview/operations.json
- Microsoft.ServiceBus/preview/2022-10-01-preview/DisasterRecoveryConfig.json
- Microsoft.ServiceBus/preview/2022-10-01-preview/migrationconfigs.json
- Microsoft.ServiceBus/preview/2022-10-01-preview/networksets.json
- Microsoft.ServiceBus/preview/2022-10-01-preview/AuthorizationRules.json
- Microsoft.ServiceBus/preview/2022-10-01-preview/Queue.json
- Microsoft.ServiceBus/preview/2022-10-01-preview/topics.json
- Microsoft.ServiceBus/preview/2022-10-01-preview/Rules.json
- Microsoft.ServiceBus/preview/2022-10-01-preview/subscriptions.json
- Microsoft.ServiceBus/preview/2022-10-01-preview/CheckNameAvailability.json
```

### Tag: package-2018-01-preview

These settings apply only when `--tag=package-2018-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-preview'
input-file:
- Microsoft.ServiceBus/preview/2018-01-01-preview/IPFilterRules-preview.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/namespace-preview.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/VirtualNetworkRules-preview.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/DisasterRecoveryConfig.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/AuthorizationRules.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/CheckNameAvailability.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/eventhubs.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/networksets.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/migrate.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/migrationconfigs.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/PremiumMessagingRegions.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/Queue.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/sku.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/subscriptions.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/topics.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/Rules.json
- Microsoft.ServiceBus/preview/2018-01-01-preview/operations.json
```

### Tag: package-2021-11

These settings apply only when `--tag=package-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-2021-11'
input-file:
- Microsoft.ServiceBus/stable/2021-11-01/namespace-preview.json
- Microsoft.ServiceBus/stable/2021-11-01/operations.json
- Microsoft.ServiceBus/stable/2021-11-01/DisasterRecoveryConfig.json
- Microsoft.ServiceBus/stable/2021-11-01/migrationconfigs.json
- Microsoft.ServiceBus/stable/2021-11-01/networksets.json
- Microsoft.ServiceBus/stable/2021-11-01/AuthorizationRules.json
- Microsoft.ServiceBus/stable/2021-11-01/Queue.json
- Microsoft.ServiceBus/stable/2021-11-01/topics.json
- Microsoft.ServiceBus/stable/2021-11-01/Rules.json
- Microsoft.ServiceBus/stable/2021-11-01/subscriptions.json
- Microsoft.ServiceBus/stable/2021-11-01/CheckNameAvailability.json
```

### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.


``` yaml $(tag) == 'package-2017-04'
input-file:
- Microsoft.ServiceBus/stable/2017-04-01/AuthorizationRules.json
- Microsoft.ServiceBus/stable/2017-04-01/CheckNameAvailability.json
- Microsoft.ServiceBus/stable/2017-04-01/DisasterRecoveryConfig.json
- Microsoft.ServiceBus/stable/2017-04-01/eventhubs.json
- Microsoft.ServiceBus/stable/2017-04-01/migrate.json
- Microsoft.ServiceBus/stable/2017-04-01/migrationconfigs.json
- Microsoft.ServiceBus/stable/2017-04-01/namespaces.json
- Microsoft.ServiceBus/stable/2017-04-01/networksets.json
- Microsoft.ServiceBus/stable/2017-04-01/operations.json
- Microsoft.ServiceBus/stable/2017-04-01/PremiumMessagingRegions.json
- Microsoft.ServiceBus/stable/2017-04-01/Queue.json
- Microsoft.ServiceBus/stable/2017-04-01/Rules.json
- Microsoft.ServiceBus/stable/2017-04-01/sku.json
- Microsoft.ServiceBus/stable/2017-04-01/subscriptions.json
- Microsoft.ServiceBus/stable/2017-04-01/topics.json
```

### Tag: package-2023-01-preview

These settings apply only when `--tag=package-2023-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-01-preview'
input-file:
- Microsoft.ServiceBus/preview/2023-01-01-preview/namespace-preview.json
- Microsoft.ServiceBus/preview/2023-01-01-preview/operations.json
- Microsoft.ServiceBus/preview/2023-01-01-preview/DisasterRecoveryConfig.json
- Microsoft.ServiceBus/preview/2023-01-01-preview/migrationconfigs.json
- Microsoft.ServiceBus/preview/2023-01-01-preview/networksets.json
- Microsoft.ServiceBus/preview/2023-01-01-preview/AuthorizationRules.json
- Microsoft.ServiceBus/preview/2023-01-01-preview/Queue.json
- Microsoft.ServiceBus/preview/2023-01-01-preview/topics.json
- Microsoft.ServiceBus/preview/2023-01-01-preview/Rules.json
- Microsoft.ServiceBus/preview/2023-01-01-preview/subscriptions.json
- Microsoft.ServiceBus/preview/2023-01-01-preview/CheckNameAvailability.json
```

### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-01'
input-file:
- Microsoft.ServiceBus/stable/2024-01-01/namespace-preview.json
- Microsoft.ServiceBus/stable/2024-01-01/operations.json
- Microsoft.ServiceBus/stable/2024-01-01/DisasterRecoveryConfig.json
- Microsoft.ServiceBus/stable/2024-01-01/migrationconfigs.json
- Microsoft.ServiceBus/stable/2024-01-01/networksets.json
- Microsoft.ServiceBus/stable/2024-01-01/AuthorizationRules.json
- Microsoft.ServiceBus/stable/2024-01-01/Queue.json
- Microsoft.ServiceBus/stable/2024-01-01/topics.json
- Microsoft.ServiceBus/stable/2024-01-01/Rules.json
- Microsoft.ServiceBus/stable/2024-01-01/subscriptions.json
- Microsoft.ServiceBus/stable/2024-01-01/CheckNameAvailability.json
```

Important notes:
On the advice of @fearthecowboy, the  `EncodingCaptureDescription` enum previously contained two values [`Avro`,`AvroDeflate`] ; the service has been changed (on 2018-01-17) and will not ever return the `AvroDeflate` value,
 however, we have left the value in the enum (in servicebus.json) so that existing clients won't suffer a binary breaking change
The `AvroDeflate` value will likely be removed in a future API version, and at that a breaking binary change may happen.

### Tag: package-2015-08

These settings apply only when `--tag=package-2015-08` is specified on the command line.

``` yaml $(tag) == 'package-2015-08'
input-file:
- Microsoft.ServiceBus/stable/2015-08-01/servicebus.json
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
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_service_bus']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.ServiceBus
  output-folder: $(csharp-sdks-folder)/servicebus/Microsoft.Azure.Management.ServiceBus/src/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Suppression

``` yaml
directive:
  - suppress: ResourceNameRestriction
    from: namespace-preview.json
    reason: Addition of Pattern restriction will cause a breaking change as there is no restriction in previous api versions.
  
  - suppress: ResourceNameRestriction
    from: AuthorizationRules.json
    reason: Addition of Pattern restriction will cause a breaking change as there is no restriction in previous api versions.
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    from: AuthorizationRules.json
    reason: Authorization rules are not tracked resources.
  - suppress: PutResponseCodes
    from: AuthorizationRules.json
    reason: Breaking change in order to change the API response code.
```


