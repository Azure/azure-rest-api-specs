
# ChangeSafety

> see https://aka.ms/autorest

This is the AutoRest configuration file for ChangeSafety.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the settings for the ChangeControl.

```yaml
openapi-type: arm
tag: package-2026-01-01-preview
openapi-subtype: providerHub
```

### Tag: package-2024-10-01-preview

These settings apply only when `--tag=package-2024-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-10-01-preview'
input-file:
  - preview/2024-10-01-preview/ChangeControl.json
```

### Tag: package-2025-03-01-preview

These settings apply only when `--tag=package-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-preview'
input-file:
  - preview/2025-03-01-preview/ChangeControl.json
```


### Tag: package-2025-07-01-preview

These settings apply only when `--tag=package-2025-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01-preview'
input-file:
  - preview/2025-07-01-preview/ChangeControl.json
```

### Tag: package-2025-09-01-preview

These settings apply only when `--tag=package-2025-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-09-01-preview'
input-file:
  - preview/2025-09-01-preview/ChangeControl.json
```

### Tag: package-2026-01-01-preview

These settings apply only when `--tag=package-2026-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-01-01-preview'
input-file:
  - preview/2026-01-01-preview/ChangeControl.json
```

---

## Suppression

``` yaml
directive:
  - suppress: AvoidAdditionalProperties
    reason: Need to use Record for key-value pair properties, got sign-off during design meeting.
    from: ChangeControl.json
    where:
      - $.definitions.ChangeStateProperties.properties.stageParameters
      - $.definitions.Parameter.properties.metadata
      - $.definitions.ParameterUpdate.properties.metadata
      - $.definitions.Stage.properties.parameterValues
      - $.definitions.StageProgressionProperties.properties.parameterValues
      - $.definitions.StageProgressionPropertiesUpdate.properties.parameterValues
      - $.definitions.RetrieveNextStagesResponseItem.properties.parameterValues
      - $.definitions.StageMapProperties.properties.parameters
      - $.definitions.StageMapPropertiesUpdate.properties.parameters
      - $.definitions.OperationContent.properties.properties
      - $.definitions.ChangeStateProperties.properties.parameters
      - $.definitions.ChangeStatePropertiesUpdate.properties.parameters
      - $.definitions.StageProgressionProperties.properties.stageVariables
      - $.definitions.StageProgressionPropertiesUpdate.properties.stageVariables
      - $.definitions.RetrieveNextStagesResponseItem.properties.stageVariables
      - $.definitions.ChangeStateProperties.properties.additionalData
      - $.definitions.ChangeStatePropertiesUpdate.properties.additionalData
      - $.definitions.StageProgressionProperties.properties.additionalData
      - $.definitions.StageProgressionPropertiesUpdate.properties.additionalData
      - $.definitions.RetrieveNextStagesResponseItem.properties.additionalData
      - $.definitions.StageVariables
      - $.definitions.ChangeDefinition.properties.details
      - $.definitions.Stage.properties.stageVariables
      - $.definitions.Stage.properties.nestedStageMap.parameters
      - $.definitions.RetrieveNextStagesResponseItem.properties.parameters
      - $.definitions.StageProgressionProperties.properties.parameters
      - $.definitions.StageProgressionPropertiesUpdate.properties.parameters
      - $.definitions.NestedStageMap.properties.parameters
      - $.definitions.ChangeRecordProperties.properties.parameters
      - $.definitions.ChangeRecordPropertiesUpdate.properties.parameters
      - $.definitions.ChangeRecordProperties.properties.additionalData
      - $.definitions.ChangeRecordPropertiesUpdate.properties.additionalData
      - $.definitions.ChangeRecordStageProgressionProperties.properties.stageVariables
      - $.definitions.ChangeRecordStageProgressionPropertiesUpdate.properties.stageVariables
      - $.definitions.ChangeRecordStageProgressionProperties.properties.additionalData
      - $.definitions.ChangeRecordStageProgressionPropertiesUpdate.properties.additionalData
      - $.definitions.ChangeRecordStageProgressionProperties.properties.parameters
      - $.definitions.ChangeRecordStageProgressionPropertiesUpdate.properties.parameters
      - $.definitions.ChangeRecordRetrieveNextStagesResponseItem.properties.stageVariables
      - $.definitions.ChangeRecordRetrieveNextStagesResponseItem.properties.additionalData
      - $.definitions.ChangeRecordRetrieveNextStagesResponseItem.properties.parameters
      - $.definitions.ChangeRecordRetrieveAllStagesResponseItemProperties.properties.stageVariables
      - $.definitions.ChangeRecordRetrieveAllStagesResponseItemProperties.properties.parameters
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-powershell
```
## Az

See configuration in [readme.az.md](./readme.az.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
