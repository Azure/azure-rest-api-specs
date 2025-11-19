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
tag: package-2025-05-preview
```

### Tag: package-2021-01-preview

These settings apply only when `--tag=package-2021-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-preview'
input-file:
- ./preview/2021-01-01-preview/namespace-preview.json
- ./preview/2021-01-01-preview/operations.json
- ./preview/2021-01-01-preview/DisasterRecoveryConfig.json
- ./preview/2021-01-01-preview/migrationconfigs.json
- ./preview/2021-01-01-preview/networksets.json
- ./preview/2021-01-01-preview/AuthorizationRules.json
- ./preview/2021-01-01-preview/Queue.json
- ./preview/2021-01-01-preview/topics.json
- ./preview/2021-01-01-preview/Rules.json
- ./preview/2021-01-01-preview/subscriptions.json
- ./preview/2021-01-01-preview/CheckNameAvailability.json
```

### Tag: package-2021-06-preview

These settings apply only when `--tag=package-2021-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-preview'
input-file:
- ./preview/2021-06-01-preview/namespace-preview.json
- ./preview/2021-06-01-preview/operations.json
- ./preview/2021-06-01-preview/DisasterRecoveryConfig.json
- ./preview/2021-06-01-preview/migrationconfigs.json
- ./preview/2021-06-01-preview/networksets.json
- ./preview/2021-06-01-preview/AuthorizationRules.json
- ./preview/2021-06-01-preview/Queue.json
- ./preview/2021-06-01-preview/topics.json
- ./preview/2021-06-01-preview/Rules.json
- ./preview/2021-06-01-preview/subscriptions.json
- ./preview/2021-06-01-preview/CheckNameAvailability.json
```

### Tag: package-2022-01-preview

These settings apply only when `--tag=package-2022-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-01-preview'
input-file:
- ./preview/2022-01-01-preview/namespace-preview.json
- ./preview/2022-01-01-preview/operations.json
- ./preview/2022-01-01-preview/DisasterRecoveryConfig.json
- ./preview/2022-01-01-preview/migrationconfigs.json
- ./preview/2022-01-01-preview/networksets.json
- ./preview/2022-01-01-preview/AuthorizationRules.json
- ./preview/2022-01-01-preview/Queue.json
- ./preview/2022-01-01-preview/topics.json
- ./preview/2022-01-01-preview/Rules.json
- ./preview/2022-01-01-preview/subscriptions.json
- ./preview/2022-01-01-preview/CheckNameAvailability.json
```

### Tag: package-2022-10-preview

These settings apply only when `--tag=package-2022-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-10-preview'
input-file:
- ./preview/2022-10-01-preview/namespace-preview.json
- ./preview/2022-10-01-preview/operations.json
- ./preview/2022-10-01-preview/DisasterRecoveryConfig.json
- ./preview/2022-10-01-preview/migrationconfigs.json
- ./preview/2022-10-01-preview/networksets.json
- ./preview/2022-10-01-preview/AuthorizationRules.json
- ./preview/2022-10-01-preview/Queue.json
- ./preview/2022-10-01-preview/topics.json
- ./preview/2022-10-01-preview/Rules.json
- ./preview/2022-10-01-preview/subscriptions.json
- ./preview/2022-10-01-preview/CheckNameAvailability.json
```

### Tag: package-2018-01-preview

These settings apply only when `--tag=package-2018-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-preview'
input-file:
- ./preview/2018-01-01-preview/IPFilterRules-preview.json
- ./preview/2018-01-01-preview/namespace-preview.json
- ./preview/2018-01-01-preview/VirtualNetworkRules-preview.json
- ./preview/2018-01-01-preview/DisasterRecoveryConfig.json
- ./preview/2018-01-01-preview/AuthorizationRules.json
- ./preview/2018-01-01-preview/CheckNameAvailability.json
- ./preview/2018-01-01-preview/eventhubs.json
- ./preview/2018-01-01-preview/networksets.json
- ./preview/2018-01-01-preview/migrate.json
- ./preview/2018-01-01-preview/migrationconfigs.json
- ./preview/2018-01-01-preview/PremiumMessagingRegions.json
- ./preview/2018-01-01-preview/Queue.json
- ./preview/2018-01-01-preview/sku.json
- ./preview/2018-01-01-preview/subscriptions.json
- ./preview/2018-01-01-preview/topics.json
- ./preview/2018-01-01-preview/Rules.json
- ./preview/2018-01-01-preview/operations.json
```

### Tag: package-2021-11

These settings apply only when `--tag=package-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-2021-11'
input-file:
- ./stable/2021-11-01/namespace-preview.json
- ./stable/2021-11-01/operations.json
- ./stable/2021-11-01/DisasterRecoveryConfig.json
- ./stable/2021-11-01/migrationconfigs.json
- ./stable/2021-11-01/networksets.json
- ./stable/2021-11-01/AuthorizationRules.json
- ./stable/2021-11-01/Queue.json
- ./stable/2021-11-01/topics.json
- ./stable/2021-11-01/Rules.json
- ./stable/2021-11-01/subscriptions.json
- ./stable/2021-11-01/CheckNameAvailability.json
```

### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.


``` yaml $(tag) == 'package-2017-04'
input-file:
- ./stable/2017-04-01/AuthorizationRules.json
- ./stable/2017-04-01/CheckNameAvailability.json
- ./stable/2017-04-01/DisasterRecoveryConfig.json
- ./stable/2017-04-01/eventhubs.json
- ./stable/2017-04-01/migrate.json
- ./stable/2017-04-01/migrationconfigs.json
- ./stable/2017-04-01/namespaces.json
- ./stable/2017-04-01/networksets.json
- ./stable/2017-04-01/operations.json
- ./stable/2017-04-01/PremiumMessagingRegions.json
- ./stable/2017-04-01/Queue.json
- ./stable/2017-04-01/Rules.json
- ./stable/2017-04-01/sku.json
- ./stable/2017-04-01/subscriptions.json
- ./stable/2017-04-01/topics.json
```

### Tag: package-2023-01-preview

These settings apply only when `--tag=package-2023-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-01-preview'
input-file:
- ./preview/2023-01-01-preview/namespace-preview.json
- ./preview/2023-01-01-preview/operations.json
- ./preview/2023-01-01-preview/DisasterRecoveryConfig.json
- ./preview/2023-01-01-preview/migrationconfigs.json
- ./preview/2023-01-01-preview/networksets.json
- ./preview/2023-01-01-preview/AuthorizationRules.json
- ./preview/2023-01-01-preview/Queue.json
- ./preview/2023-01-01-preview/topics.json
- ./preview/2023-01-01-preview/Rules.json
- ./preview/2023-01-01-preview/subscriptions.json
- ./preview/2023-01-01-preview/CheckNameAvailability.json
```

### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-01'
input-file:
- ./stable/2024-01-01/namespace-preview.json
- ./stable/2024-01-01/operations.json
- ./stable/2024-01-01/DisasterRecoveryConfig.json
- ./stable/2024-01-01/migrationconfigs.json
- ./stable/2024-01-01/networksets.json
- ./stable/2024-01-01/AuthorizationRules.json
- ./stable/2024-01-01/Queue.json
- ./stable/2024-01-01/topics.json
- ./stable/2024-01-01/Rules.json
- ./stable/2024-01-01/subscriptions.json
- ./stable/2024-01-01/CheckNameAvailability.json
```

### Tag: package-2025-05-preview

These settings apply only when `--tag=package-2025-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-05-preview'
input-file:
- ./preview/2025-05-01-preview/servicebus.json
```

Important notes:
On the advice of @fearthecowboy, the  `EncodingCaptureDescription` enum previously contained two values [`Avro`,`AvroDeflate`] ; the service has been changed (on 2018-01-17) and will not ever return the `AvroDeflate` value,
 however, we have left the value in the enum (in servicebus.json) so that existing clients won't suffer a binary breaking change
The `AvroDeflate` value will likely be removed in a future API version, and at that a breaking binary change may happen.

### Tag: package-2015-08

These settings apply only when `--tag=package-2015-08` is specified on the command line.

``` yaml $(tag) == 'package-2015-08'
input-file:
- ./stable/2015-08-01/servicebus.json
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
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_service_bus']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
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
  - suppress: LroErrorContent
    from: servicebus.json
    reason: Suppress it for now to avoid breaking change because it is referenced by many files.Will update in next api version.Please scope the suppression to the Namespaces PATCH operation only.
```


