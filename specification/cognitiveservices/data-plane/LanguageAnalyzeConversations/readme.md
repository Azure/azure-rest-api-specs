# Cognitive Services Language SDK

This is the AutoRest configuration file the Cognitive Services Language SDK.

> see https://aka.ms/autorest

## Configuration

The current preview release of Language is 2025-05-15-preview.

The current stable release of Language is 2024-11-01.

### Basic Information

```yaml
tag: release_2025_05_15_preview
add-credentials: true
clear-output-folder: true
openapi-type: data-plane
directive:
  - suppress: LongRunningResponseStatusCode
    reason: The validation tools do not properly recognize 202 as a supported response code.
  - suppress: R3016
    where: $.definitions.CurrencyResolution.properties.ISO4217
    reason: ISO should be upper case.
```

### Release 2025-11-15-preview

These settings apply only when `--tag=release_2025_11_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2025-11-15-preview'
input-file:
  - preview/2025-11-15-preview/analyzeconversations.json
title:
  Microsoft Cognitive Language Service - Conversations
modelerfour:
  lenient-model-deduplication: true
```

### Release 2025-05-15-preview

These settings apply only when `--tag=release_2025_05_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2025-05-15-preview'
input-file:
  - preview/2025-05-15-preview/analyzeconversations.json
title:
  Microsoft Cognitive Language Service - Conversations
modelerfour:
  lenient-model-deduplication: true
```

### Release 2024-11-15-preview

These settings apply only when `--tag=release_2024_11_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2024-11-15-preview'
input-file:
  - preview/2024-11-15-preview/analyzeconversations.json
title:
  Microsoft Cognitive Language Service - Conversations
modelerfour:
  lenient-model-deduplication: true
```

### Release 2024-11-01

These settings apply only when `--tag=release_2024_11_01` is specified on the command line.

``` yaml $(tag) == 'release_2024-11-01'
input-file:
  - stable/2024-11-01/analyzeconversations.json
title:
  Microsoft Cognitive Language Service - Conversations
modelerfour:
  lenient-model-deduplication: true
```

### Release 2024-05-15-preview

These settings apply only when `--tag=release_2024_05_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2024-05-15-preview'
input-file:
  - preview/2024-05-15-preview/analyzeconversations.json
title:
  Microsoft Cognitive Language Service - Conversations
modelerfour:
  lenient-model-deduplication: true
suppressions:
  - code: SecurityDefinitionDescription
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
  - code: OperationId
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
  - code: GetInOperationName
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
  - code: PathParameterSchema
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
  - code: EnumInsteadOfBoolean
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
  - code: EnumInsteadOfBoolean
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
```

### Release 2024-05-01

These settings apply only when `--tag=release_2024_05_01` is specified on the command line.

``` yaml $(tag) == 'release_2024-05-01'
input-file:
  - stable/2024-05-01/analyzeconversations.json
title:
  Microsoft Cognitive Language Service - Conversations
modelerfour:
  lenient-model-deduplication: true
```

### Release 2023-11-15-preview

These settings apply only when `--tag=release_2023_11_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2023-11-15-preview'
input-file:
  - preview/2023-11-15-preview/analyzeconversations.json
title:
  Microsoft Cognitive Language Service - Conversations
modelerfour:
  lenient-model-deduplication: true
suppressions:
  - code: SecurityDefinitionDescription
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
  - code: OperationId
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
  - code: GetInOperationName
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
  - code: PathParameterSchema
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
  - code: EnumInsteadOfBoolean
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
  - code: EnumInsteadOfBoolean
    reason: Older preview version not generated through typespec. Won't fix. Cleanup stale preview instead.
```

### Release 2023-04-01

These settings apply only when `--tag=release_2023_04_01` is specified on the command line.

``` yaml $(tag) == 'release_2023_04_01'
input-file:
  - stable/2023-04-01/analyzeconversations.json
title:
  Microsoft Cognitive Language Service - Conversations
modelerfour:
  lenient-model-deduplication: true

```

### Release 2022-05-01

These settings apply only when `--tag=release_2022_05_01` is specified on the command line.

``` yaml $(tag) == 'release_2022_05_01'
input-file:
  - stable/2022-05-01/analyzeconversations.json
title:
  Microsoft Cognitive Language Service - Conversations
modelerfour:
  lenient-model-deduplication: true
```

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
```
