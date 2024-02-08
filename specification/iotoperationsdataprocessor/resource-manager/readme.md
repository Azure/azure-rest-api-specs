# IoTOperationsDataProcessor

> see https://aka.ms/autorest

This is the AutoRest configuration file for IoTOperationsDataProcessor.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

## Suppression

``` yaml
directive:
  - suppress: AvoidAdditionalProperties
    where: $.definitions.Message.properties.data
    reason: We're unable to map data coming from IoT devices to a fixed schema.
  - suppress: AvoidAdditionalProperties
    where: $.definitions.DataSourceInputSampling.properties.input
    reason: Reusing $definitions.PipelineInput modal that was approved during the review for 2023-10-04-preview API version.
  - suppress: AvoidAdditionalProperties
    where: $.definitions.DataSourceMessages.properties.messages.items.properties.data
    reason: We're unable to map data coming from IoT devices to a fixed schema.
  - suppress: AvoidAdditionalProperties
    where: $.definitions.TestRunRequest.properties.stages
    reason: Reusing $definitions.PipelineStage modal that was approved during the review for 2023-10-04-preview API version.
  - suppress: AvoidAdditionalProperties
    where: $.definitions.TestRunRequest.properties.stages.additionalProperties
    reason: Reusing $definitions.PipelineStage modal that was approved during the review for 2023-10-04-preview API version.
  - suppress: AvoidAdditionalProperties
    where: $.definitions.TestRunResponse.properties.messages.items.properties.data
    reason: We're unable to map data coming from IoT devices to a fixed schema.
```

### Basic Information

These are the global settings for the IoTOperationsDataProcessor.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-02-01-preview
```

### Tag: package-2024-02-01-preview

These settings apply only when `--tag=package-2024-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-02-01-preview'
input-file:
  - Microsoft.IoTOperationsDataProcessor/preview/2024-02-01-preview/openapi.json
```

### Tag: package-2023-10-04-preview

These settings apply only when `--tag=package-2023-10-04-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-10-04-preview'
input-file:
  - Microsoft.IoTOperationsDataProcessor/preview/2023-10-04-preview/openapi.json
```
