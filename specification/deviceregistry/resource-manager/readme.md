# Azure Device Registry

> see https://aka.ms/autorest

## Getting Started

To build the SDKs for Azure Device Registry, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Azure Device Registry.

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2023-11
```


### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-11'
input-file:
  - Microsoft.DeviceRegistry/preview/2023-11-01-preview/openapi.json

suppressions:
  - code: AvoidAdditionalProperties
    from: openapi.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
  - code: PropertiesTypeObjectNoDefinition
    from: openapi.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
```
