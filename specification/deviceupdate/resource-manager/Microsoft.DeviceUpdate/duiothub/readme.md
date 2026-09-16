# Microsoft.DeviceUpdate - IoT Hub

> see https://aka.ms/autorest

This is the AutoRest configuration file for Device Update for IoT Hub under Microsoft.DeviceUpdate.

## Configuration

### Basic Information

These are the global settings for Device Update for IoT Hub.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2022-10-01
```

### Tag: package-2023-09-01-preview

These settings apply only when `--tag=package-2023-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-09-01-preview'
input-file:
 - preview/2023-09-01-preview/deviceupdate.json
```

### Tag: package-2022-10-01

These settings apply only when `--tag=package-2022-10-01` is specified on the command line.

```yaml $(tag) == 'package-2022-10-01'
input-file:
 - stable/2022-10-01/deviceupdate.json
```

### Tag: package-2022-04-01-preview

These settings apply only when `--tag=package-2022-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-04-01-preview'
input-file:
 - preview/2022-04-01-preview/deviceupdate.json
```

### Tag: package-2020-03-01-preview

These settings apply only when `--tag=package-2020-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-03-01-preview'
input-file:
 - preview/2020-03-01-preview/deviceupdate.json
```

## Suppression

```yaml
directive:
  - suppress: ENUM_CASE_MISMATCH
    where: $.definitions.Identity.properties.type
    from: deviceupdate.json
    reason: Managed Identity type can be case-insensitive
  - suppress: BodyTopLevelProperties
    from: deviceupdate.json
    where: $.definitions.PrivateEndpointConnectionProxy
    reason: Internal NRP resource, all properties are top-level properties
```
