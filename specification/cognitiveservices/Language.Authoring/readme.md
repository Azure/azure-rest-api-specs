# Cognitive Services Language SDK

This is the AutoRest configuration file the Cognitive Services Language SDK.

> see https://aka.ms/autorest

## Releases

The current preview release of Language is 2024-05-15-preview.

The current stable release of Language is 2024-05-01.

```yaml
tag: release_2023_04_15-preview
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

### Release 2023-04-15-preview

These settings apply only when `--tag=release_2023_04_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2023_04_15-preview'
input-file:
  - examples/2023-04-15-preview/language-authoring.json
title:
  Microsoft Cognitive Language Service
modelerfour:
  lenient-model-deduplication: true
```