# Cognitive Services Language SDK

This is the AutoRest configuration file the Cognitive Services Language SDK.

> see https://aka.ms/autorest

## Releases

The current preview release of Language is 2024-05-15-preview.

The current stable release of Language is 2024-05-01.

```yaml
tag: release_2024-05-15-preview
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
### Release 2024-05-15-preview

These settings apply only when `--tag=release_2024_05_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2024-05-15-preview'
input-file:
  - preview/2024-05-15-preview/analyzeconversations.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```

### Release 2024-05-01

These settings apply only when `--tag=release_2024_05_01` is specified on the command line.

``` yaml $(tag) == 'release_2024-05-01'
input-file:
  - stable/2024-05-01/analyzeconversations.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```


### Release 2023-11-15-preview

These settings apply only when `--tag=release_2023_11_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2023-11-15-preview'
input-file:
  - preview/2023-11-15-preview/analyzetext.json
  - preview/2023-11-15-preview/analyzetext-authoring.json
  - preview/2023-11-15-preview/analyzeconversations.json
  - preview/2023-11-15-preview/analyzeconversations-authoring.json
  - preview/2023-11-15-preview/analyzedocuments.json
  - preview/2023-11-15-preview/questionanswering.json
  - preview/2023-11-15-preview/questionanswering-authoring.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```

### Release 2023-04-15-preview

These settings apply only when `--tag=release_2023_04_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2023-04-15-preview'
input-file:
  - preview/2023-04-15-preview/analyzetext.json
  - preview/2023-04-15-preview/analyzetext-authoring.json
  - preview/2023-04-15-preview/analyzeconversations.json
  - preview/2023-04-15-preview/analyzeconversations-authoring.json
  - preview/2023-04-15-preview/questionanswering.json
  - preview/2023-04-15-preview/questionanswering-authoring.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```

### Release 2023-04-01

These settings apply only when `--tag=release_2023_04_01` is specified on the command line.

``` yaml $(tag) == 'release_2023_04_01'
input-file:
  - stable/2023-04-01/analyzetext.json
  - stable/2023-04-01/analyzetext-authoring.json
  - stable/2023-04-01/analyzeconversations.json
  - stable/2023-04-01/analyzeconversations-authoring.json
  - stable/2023-04-01/questionanswering.json
  - stable/2023-04-01/questionanswering-authoring.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true

```

### Release 2022-10-01-preview

These settings apply only when `--tag=release_2022_10_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2022_10_01_preview'
input-file:
  - preview/2022-10-01-preview/analyzetext.json
  - preview/2022-10-01-preview/analyzetext-authoring.json
  - preview/2022-10-01-preview/analyzeconversations.json
  - preview/2022-10-01-preview/analyzeconversations-authoring.json
  - preview/2022-10-01-preview/questionanswering.json
  - preview/2022-10-01-preview/questionanswering-authoring.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true

```

### Release 2022-07-01-preview

These settings apply only when `--tag=release_2022_07_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2022_07_01_preview'
input-file:
  - preview/2022-07-01-preview/analyzetext.json
  - preview/2022-07-01-preview/analyzeconversations.json
  - preview/2022-07-01-preview/analyzetext-authoring.json
  - preview/2022-07-01-preview/analyzeconversations-authoring.json
  - preview/2022-07-01-preview/questionanswering.json
  - preview/2022-07-01-preview/questionanswering-authoring.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true

```

### Release 2022-05-15-preview

These settings apply only when `--tag=release_2022_05_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2022_05_15_preview'
input-file:
  - preview/2022-05-15-preview/analyzetext.json
  - preview/2022-05-15-preview/analyzeconversations.json
  - preview/2022-05-15-preview/analyzetext-authoring.json
  - preview/2022-05-15-preview/analyzeconversations-authoring.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true

```

### Release 2022-05-01

These settings apply only when `--tag=release_2022_05_01` is specified on the command line.

``` yaml $(tag) == 'release_2022_05_01'
input-file:
  - stable/2022-05-01/analyzetext.json
  - stable/2022-05-01/analyzetext-authoring.json
  - stable/2022-05-01/analyzeconversations-authoring.json
  - stable/2022-05-01/analyzeconversations.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```
### Release 2022-03-01-preview

These settings apply only when `--tag=release_2022_03_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2022_03_01_preview'
input-file:
  - preview/2022-03-01-preview/analyzetext.json
  - preview/2022-03-01-preview/analyzeconversations.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```

### Release 2022-02-01-preview

These settings apply only when `--tag=release_2022_02_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2022_02_01_preview'
input-file:
- preview/2022-02-01-preview/analyzetext.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```

### Release 2021-11-01-preview

These settings apply only when `--tag=release_2021_11_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2021_11_01_preview'
input-file:
- preview/2021-11-01-preview/analyzetext.json
- preview/2021-11-01-preview/analyzeconversations.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```

### Release 2021-10-01

These settings apply only when `--tag=release_2021_10_01` is specified on the command line.

``` yaml $(tag) == 'release_2021_10_01'
input-file: 
  - stable/2021-10-01/questionanswering.json
  - stable/2021-10-01/questionanswering-authoring.json
title: 
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```

### Release 2021-07-15-preview

These settings apply only when `--tag=release_2021_07_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2021_07_15_preview'
input-file:
- preview/2021-07-15-preview/questionanswering.json
- preview/2021-07-15-preview/questionanswering-authoring.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```

### Release 2021-05-01-preview

These settings apply only when `--tag=release_2021_05_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2021_05_01_preview'
input-file:
- preview/2021-05-01-preview/questionanswering.json
- preview/2021-05-01-preview/questionanswering-authoring.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
```
