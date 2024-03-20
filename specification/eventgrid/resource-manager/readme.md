# EventGrid

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure EventGrid.

---

## Getting Started

To build the SDK for Azure EventGrid, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Azure EventGrid API.

``` yaml
openapi-type: arm
tag: package-2023-12-preview
```

### Tag: package-2023-12-preview

These settings apply only when `--tag=package-2023-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-12-preview'
input-file:
- Microsoft.EventGrid/preview/2023-12-15-preview/EventGrid.json

suppressions:
  - code:  PathContainsResourceType
    reason: This is false positive error because the resourceType is already defined in the path as an enum of domains and topics. This same style we used previously in other routes and it allows us to extend this route in the future with other resource types once we add support without the need for adding additional routes and operation Ids.
    from: EventGrid.json

  - code:  PathResourceTypeNameCamelCase
    reason: This is false positive error because the resourceType is already defined in the path as an enum of domains and topics and its values are following camel casing. This same style we used previously in other routes and it allows us to extend this route in the future with other resource types once we add support without the need for adding additional routes and operation Ids.
    from: EventGrid.json

  - code:  PathForResourceAction
    reason: This route definition is defined by NSP for all partner services and the right integration with NSP relies on that. We cannot change this as we don't own the contract here and in order for the NSP integration to work, we need to adhere to NSP requirements in this route defintion.
    from: EventGrid.json
```

### Tag: package-2023-06-preview

These settings apply only when `--tag=package-2023-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-06-preview'
input-file:
- Microsoft.EventGrid/preview/2023-06-01-preview/EventGrid.json
```

### Tag: package-2022-06

These settings apply only when `--tag=package-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-2022-06'
input-file:
- Microsoft.EventGrid/stable/2022-06-15/EventGrid.json
```

### Tag: package-2021-10-preview

These settings apply only when `--tag=package-2021-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-10-preview'
input-file:
- Microsoft.EventGrid/preview/2021-10-15-preview/EventGrid.json
```

### Tag: package-2021-12

These settings apply only when `--tag=package-2021-12` is specified on the command line.

``` yaml $(tag) == 'package-2021-12'
input-file:
- Microsoft.EventGrid/stable/2021-12-01/EventGrid.json
```

## Suppression

``` yaml
directive:
  - suppress: OperationsApiResponseSchema
    from: EventGrid.json
    reason: Error is complaining about a section that already exists in all previous stable and preview swaggers.
```

### Tag: package-2021-06-preview

These settings apply only when `--tag=package-2021-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-preview'
input-file:
- Microsoft.EventGrid/preview/2021-06-01-preview/EventGrid.json
```

### Tag: package-2020-10-preview

These settings apply only when `--tag=package-2020-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-10-preview'
input-file:
- Microsoft.EventGrid/preview/2020-10-15-preview/EventGrid.json
```

### Tag: package-2020-06

These settings apply only when `--tag=package-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-2020-06'
input-file:
- Microsoft.EventGrid/stable/2020-06-01/EventGrid.json
```

### Tag: package-2020-04-preview

These settings apply only when `--tag=package-2020-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-preview'
input-file:
- Microsoft.EventGrid/preview/2020-04-01-preview/EventGrid.json
```

### Tag: package-2020-01-preview

These settings apply only when `--tag=package-2020-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-preview'
input-file:
- Microsoft.EventGrid/preview/2020-01-01-preview/EventGrid.json
```

### Tag: package-2019-06

These settings apply only when `--tag=package-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-2019-06'
input-file:
- Microsoft.EventGrid/stable/2019-06-01/EventGrid.json
```

### Tag: package-2019-02-preview

These settings apply only when `--tag=package-2019-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-02-preview'
input-file:
- Microsoft.EventGrid/preview/2019-02-01-preview/EventGrid.json
```

### Tag: package-2019-01

These settings apply only when `--tag=package-2019-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-01'
input-file:
- Microsoft.EventGrid/stable/2019-01-01/EventGrid.json
```

## Suppression

``` yaml
directive:
  - suppress: TrackedResourcePatchOperation
    from: EventGrid.json
    reason: PATCH operation already exists in the json file but this is known issue in the ARM validation.
```

### Tag: package-2018-09-preview

These settings apply only when `--tag=package-2018-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-preview'
input-file:
- Microsoft.EventGrid/preview/2018-09-15-preview/EventGrid.json
```

## Suppression

``` yaml
directive:
  - suppress: TrackedResourcePatchOperation
    from: EventGrid.json
    reason: PATCH operation already exists in the json file but this is known issue in the ARM validation.
  - suppress: ONE_OF_MULTIPLE
    from: EventGrid.json
    where: $.definitions.EventSubscriptionProperties.properties.destination
    reason: |-
      This is a false positive. We have multiple EventSubscriptionDestination types (EventHubEventSubscriptionDestination, HybridConnectionEventSubscriptionDestination etc.) and each of them has corresponding property classes e.g. EventHubEventSubscriptionDestinationProperties and HybridConnectionEventSubscriptionDestinationProperties have both a property called resourceId which is why the validation appears to be flagging this.

      However, the discriminator value (endpointType) is separate for each of these destinations, hence based on the discriminator it will get deserialized into the appropriate type.
```

### Tag: package-2018-05-preview

These settings apply only when `--tag=package-2018-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-05-preview'
input-file:
- Microsoft.EventGrid/preview/2018-05-01-preview/EventGrid.json
```

### Tag: package-2018-01

These settings apply only when `--tag=package-2018-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-01'
input-file:
- Microsoft.EventGrid/stable/2018-01-01/EventGrid.json
```

### Tag: package-2017-09-preview

These settings apply only when `--tag=package-2017-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-09-preview'
input-file:
- Microsoft.EventGrid/preview/2017-09-15-preview/EventGrid.json
```

### Tag: package-2017-06-preview

These settings apply only when `--tag=package-2017-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-06-preview'
input-file:
- Microsoft.EventGrid/preview/2017-06-15-preview/EventGrid.json
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
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_event_grid']
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
  namespace: Microsoft.Azure.Management.EventGrid
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/eventgrid/Microsoft.Azure.Management.EventGrid/src/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)



