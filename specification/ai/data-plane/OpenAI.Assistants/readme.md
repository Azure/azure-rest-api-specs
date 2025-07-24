# AI OpenAI.Assistants SDK

> see https://aka.ms/autorest

Configuration for generating AzureOpenAI Inference SDK.

The current release for the AzureOpenAI is `release_2024_05_01`.

``` yaml
tag: release_2023_05_15
add-credentials: true
openapi-type: data-plane
```

## Suppression

``` yaml
directive:
  - suppress: INVALID_TYPE
    from: assistants_generated.json
    reason: A bug in oav is preventing a x-nullable attribute on incomplete_details from being honored.
```

# Releases

## OpenAI.Assistants 2024-02-15-preview (generated)
These settings apply only when `--tag=release_2024_02_15_preview_autogen` is specified on the command line.

``` yaml $(tag) == 'release_2024_02_15_preview_autogen'
input-file: OpenApiV2/preview/2024-02-15-preview/assistants_generated.json
```

## OpenAI.Assistants 2024-05-01-preview (generated)
These settings apply only when `--tag=release_2024_05_01_preview_autogen` is specified on the command line.

``` yaml $(tag) == 'release_2024_05_01_preview_autogen'
input-file: OpenApiV2/preview/2024-05-01-preview/assistants_generated.json
```

## OpenAI.Assistants 2024-07-01-preview (generated)
These settings apply only when `--tag=release_2024_07_01_preview_autogen` is specified on the command line.

``` yaml $(tag) == 'release_2024_07_01_preview_autogen'
input-file: OpenApiV2/preview/2024-07-01-preview/assistants_generated.json
```

## OpenAI.Assistants 2024-09-01-preview (generated)
These settings apply only when `--tag=release_2024_09_01_preview_autogen` is specified on the command line.

``` yaml $(tag) == 'release_2024_09_01_preview_autogen'
input-file: OpenApiV2/preview/2024-09-01-preview/assistants_generated.json
```

## OpenAI.Assistants 2024-10-01-preview (generated)
These settings apply only when `--tag=release_2024_10_01_preview_autogen` is specified on the command line.

``` yaml $(tag) == 'release_2024_10_01_preview_autogen'
input-file: OpenApiV2/preview/2024-10-01-preview/assistants_generated.json
```

## OpenAI.Assistants 2025-01-01-preview (generated)
These settings apply only when `--tag=release_2025_01_01_preview_autogen` is specified on the command line.

``` yaml $(tag) == 'release_2025_01_01_preview_autogen'
input-file: OpenApiV2/preview/2025-01-01-preview/assistants_generated.json
```
