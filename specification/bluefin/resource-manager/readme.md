# bluefin

> see https://aka.ms/autorest

This is the AutoRest configuration file for bluefin.

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
  - suppress: PutRequestResponseSchemeArm
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Bluefin/instances/{instanceName}/datasets/{datasetName}"].put
    reason: This is a false positive, Datasets GET & PUT responses return '#/definitions/Dataset'
  - suppress: PutRequestResponseSchemeArm
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Bluefin/instances/{instanceName}/pipelines/{pipelineName}"].put
    reason: This is a false positive, Pipelines GET & PUT responses return '#/definitions/Pipeline'
  - suppress: PutResponseSchemaDescription
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Bluefin/instances/{instanceName}"].put.responses
    reason: Typespec does not allow you to update description of common ARM responses.
  - suppress: PutResponseSchemaDescription
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Bluefin/instances/{instanceName}/datasets/{datasetName}"].put.responses
    reason: Typespec does not allow you to update description of common ARM responses.
  - suppress: PutResponseSchemaDescription
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Bluefin/instances/{instanceName}/pipelines/{pipelineName}"].put.responses
    reason: Typespec does not allow you to update description of common ARM responses.
```

### Basic Information

These are the global settings for the bluefin.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2023-06-26-preview
```

### Tag: package-2023-06-26-preview

These settings apply only when `--tag=package-2023-06-26-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-06-26-preview'
input-file:
  - Microsoft.Bluefin/preview/2023-06-26-preview/openapi.json
```
