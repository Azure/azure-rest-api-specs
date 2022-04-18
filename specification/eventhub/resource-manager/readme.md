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
tag: package-2021-11
```

### Suppression

``` yaml
directive:
  - suppress: R4007
    reason: DefaultErrorResponseSchema - we will be Implementing in new API version
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
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_event_hub']
  - repo: azure-resource-manager-schemas
```


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.EventHub
  output-folder: $(csharp-sdks-folder)/eventhub/Microsoft.Azure.Management.EventHub/src/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)



