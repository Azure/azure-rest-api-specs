# Slis

> see https://aka.ms/autorest

This is the AutoRest configuration file for Slis.

## Getting Started

To build the SDKs for the Slis API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Slis.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-03-01-preview
```

### Tag: package-2025-03-01-preview

These settings apply only when `--tag=package-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-preview'
input-file:
  - preview/2025-03-01-preview/openapi.json
```

```yaml
directive:
  - suppress: OperationsAPIImplementation
    reason: Operations API was moved to its own service.
    from: openapi.json

  - suppress: TenantLevelAPIsNotAllowed
    reason: SLIs scenarios are modelled around a SG (Service Group), which is a Tenant level resource.
    from: openapi.json

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypesDataDictionary.properties.Burnrate
    from: openapi.json
    reason: This property name needs to match the service response format for sampling type data.

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypesDataDictionary.properties.Good
    from: openapi.json
    reason: This property name needs to match the service response format for sampling type data.

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypesDataDictionary.properties.Total
    from: openapi.json
    reason: This property name needs to match the service response format for sampling type data.

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypesDataDictionary.properties.Value
    from: openapi.json
    reason: This property name needs to match the service response format for sampling type data.

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypesDataDictionary.properties.Uptime
    from: openapi.json
    reason: This property name needs to match the service response format for sampling type data.

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypesDataDictionary.properties.Downtime
    from: openapi.json
    reason: This property name needs to match the service response format for sampling type data.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.TimeSeriesData.properties.dimensionValues
    from: openapi.json
    reason: The dimensionValues property is a dictionary where keys are dynamic dimension names provided by customers in their queries, requiring the use of additionalProperties.

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypeProjection.x-ms-enum.values[?(@.name == 'Value')].name
    from: openapi.json
    reason: This enum value name needs to match the service response format for sampling type data.

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypeProjection.x-ms-enum.values[?(@.name == 'Good')].name
    from: openapi.json
    reason: This enum value name needs to match the service response format for sampling type data.

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypeProjection.x-ms-enum.values[?(@.name == 'Total')].name
    from: openapi.json
    reason: This enum value name needs to match the service response format for sampling type data.

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypeProjection.x-ms-enum.values[?(@.name == 'Uptime')].name
    from: openapi.json
    reason: This enum value name needs to match the service response format for sampling type data.

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypeProjection.x-ms-enum.values[?(@.name == 'Downtime')].name
    from: openapi.json
    reason: This enum value name needs to match the service response format for sampling type data.

  - suppress: DefinitionsPropertiesNamesCamelCase
    where: $.definitions.SamplingTypeProjection.x-ms-enum.values[?(@.name == 'Burnrate')].name
    from: openapi.json
    reason: This enum value name needs to match the service response format for sampling type data.
```