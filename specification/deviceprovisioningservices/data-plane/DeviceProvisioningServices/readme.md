# Device Provisioning Service

> see https://aka.ms/autorest

This is the AutoRest configuration file for Device Provisioning Service.

> **TypeSpec Migration**: The stable `2021-10-01` and preview `2025-07-01-preview` device and service APIs have been migrated to TypeSpec.
> The OpenAPI files in `stable/2021-10-01/` and `preview/2025-07-01-preview/` are now generated from TypeSpec source.
> TypeSpec source files (versioned — emit both stable and preview):
> - Device API: [device/main.tsp](device/main.tsp)
> - Service API: [service/main.tsp](service/main.tsp)

---

## Getting Started

To build the SDK for Device Provisioning Service, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the API.

``` yaml
openapi-type: data-plane
tag: package-2021-10-01-device
```

### Tag: package-preview-2025-07-service

These settings apply only when `--tag=package-preview-2025-07-service` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-07-service'
input-file:
  - preview/2025-07-01-preview/service.json
title: ProvisioningServiceClient
```

### Tag: package-preview-2025-07-device

These settings apply only when `--tag=package-preview-2025-07-device` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-07-device'
input-file:
  - preview/2025-07-01-preview/device.json
title: ProvisioningDeviceClient
```

### Tag: package-2021-10-01-service

These settings apply only when `--tag=package-2021-10-01-service` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-service'
input-file:
  - stable/2021-10-01/service.json
title: ProvisioningServiceClient
```

### Tag: package-2021-10-01-device

These settings apply only when `--tag=package-2021-10-01-device` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-device'
input-file:
  - stable/2021-10-01/device.json
title: ProvisioningDeviceClient
```
---

## Suppression

``` yaml
suppressions:
  - code: OperationId
    from: device.json
    reason: >-
      Pre-existing DPS device API operation IDs do not follow the Create/Update naming
      convention. Maintained for backward compatibility with existing DPS SDK clients.
  - code: PutInOperationName
    from: device.json
    reason: >-
      Pre-existing DPS device API PUT operation IDs do not include Create/Update/Replace.
      Maintained for backward compatibility.
  - code: ParameterOrder
    from: device.json
    reason: >-
      Pre-existing DPS device API parameter ordering maintained for backward compatibility.
  - code: PathParameterSchema
    from: device.json
    reason: >-
      Pre-existing DPS device API path parameter schema maintained for backward compatibility.
  - code: GetInOperationName
    from: device.json
    reason: >-
      Pre-existing DPS device API GET operation IDs do not follow the List/Get naming
      convention. Maintained for backward compatibility with existing DPS SDK clients.
  - code: PutPath
    from: device.json
    reason: >-
      Pre-existing DPS device API PUT path does not follow ARM naming guidelines.
      Maintained for backward compatibility with existing DPS device clients.
  - code: PutRequestResponseScheme
    from: device.json
    reason: >-
      Pre-existing DPS device API PUT request/response scheme does not match ARM guidelines.
      Maintained for backward compatibility with existing DPS device clients.
  - code: LroHeaders
    from: device.json
    reason: >-
      Pre-existing DPS device API LRO response does not include standard LRO headers.
      Maintained for backward compatibility with existing DPS device clients.
  - code: ErrorResponse
    from: device.json
    reason: >-
      Pre-existing DPS device API uses a custom error response format predating ARM guidelines.
      Maintained for backward compatibility.
  - code: ErrorResponse
    from: service.json
    reason: >-
      DPS service API (TypeSpec-generated) uses a custom error response format matching
      the pre-existing DPS API contract. Maintained for backward compatibility.
  - code: PathParameterSchema
    from: service.json
    reason: >-
      TypeSpec-generated DPS service API path parameters do not include maxLength/pattern
      constraints. Pre-existing API design maintained for backward compatibility.
  - code: SummaryAndDescriptionMustNotBeSame
    from: service.json
    reason: >-
      TypeSpec-generated DPS service API has operations where summary and description are
      identical. Pre-existing API design maintained for backward compatibility.
  - code: OperationIdNounConflictingModelNames
    from: service.json
    reason: >-
      TypeSpec-generated DPS service API operation IDs conflict with model names per this rule.
      This is a pre-existing API design pattern maintained for SDK compatibility.
  - code: PaginationResponse
    from: service.json
    reason: >-
      DPS service API pagination response format does not follow ARM paging guidelines.
      This is a pre-existing API design decision maintained for backward compatibility.
  - code: EnumInsteadOfBoolean
    from: service.json
    reason: >-
      DPS service API uses boolean fields where enum is suggested. This is a pre-existing
      API design decision maintained for backward compatibility.
  - code: AdditionalPropertiesObject
    from: service.json
    reason: >-
      DPS service API model uses additionalProperties of type object. This is a pre-existing
      API design decision maintained for backward compatibility.
```

---

# Code Generation

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)
