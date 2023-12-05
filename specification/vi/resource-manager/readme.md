# vi

> see https://aka.ms/autorest
This is the AutoRest configuration file for Azure Video Analyzer for Media.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Suppression
```
directive:
  - suppress: SECRET_PROPERTY
    from:
      - Microsoft.VideoIndexer/preview/2021-07-01-preview/vi.json
      - Microsoft.VideoIndexer/preview/2021-08-01-preview/vi.json
      - Microsoft.VideoIndexer/preview/2021-08-16-preview/vi.json
      - Microsoft.VideoIndexer/preview/2021-09-01-preview/vi.json
      - Microsoft.VideoIndexer/preview/2021-10-01-preview/vi.json
      - Microsoft.VideoIndexer/preview/2021-10-18-preview/vi.json
      - Microsoft.VideoIndexer/preview/2023-06-02-preview/vi.json
      - Microsoft.VideoIndexer/preview/2023-08-01-preview/vi.json
      - Microsoft.VideoIndexer/preview/2023-09-01-preview/vi.json

    where:
      - $.definitions.AccessToken.properties.accessToken
      - $.definitions.CognitiveServicesSecrets.properties.speechCognitiveServicesPrimaryKey
      - $.definitions.CognitiveServicesSecrets.properties.speechCognitiveServicesSecondaryKey
      - $.definitions.CognitiveServicesSecrets.properties.translatorCognitiveServicesPrimaryKey
      - $.definitions.CognitiveServicesSecrets.properties.translatorCognitiveServicesSecondaryKey
      - $.definitions.CognitiveServicesSecrets.properties.ocrCognitiveServicesPrimaryKey
      - $.definitions.CognitiveServicesSecrets.properties.ocrCognitiveServicesSecondaryKey
    reason: Secrets are OK to return in a POST response.

    suppressions:
  - code: AddedOptionalProperty
    reason: Design forces this behavior (and it's actually the correct behavior that doesn't violate Microsoft API guidelines).
  - code: AddedReadOnlyPropertyInResponse
    reason: Design forces this behavior (and it's actually the correct behavior that doesn't violate Microsoft API guidelines).
  - code: ReferenceRedirection
    reason: Rename that does not affect api usage. It is solely semantic and does not violate Microsoft API guidelines.

```
---

## Configuration

### Basic Information

These are the global settings for the adp.

```yaml
title: ViManagementClient
openapi-type: arm
openapi-subtype: rpaas
tag: package-2023-09-01-preview
```

### Tag: package-2023-09-01-preview

These settings apply only when `--tag=package-2023-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-09-01-preview'
version: 2023-09-01-preview
version-with-underscores: 2023_09_01_preview
input-file:
  - Microsoft.VideoIndexer/preview/2023-09-01-preview/vi.json
```

### Tag: package-2023-08-01-preview

These settings apply only when `--tag=package-2023-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-08-01-preview'
version: 2023-08-01-preview
version-with-underscores: 2023_08_01_preview
input-file:
  - Microsoft.VideoIndexer/preview/2023-08-01-preview/vi.json
```

### Tag: package-2023-06-02-preview

These settings apply only when `--tag=package-2023-06-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-06-02-preview'
version: 2023-06-02-preview
version-with-underscores: 2023_06_02_preview
input-file:
  - Microsoft.VideoIndexer/preview/2023-06-02-preview/vi.json
```

### Tag: package-2021-10-18-preview

These settings apply only when `--tag=2021-10-18-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-10-18-preview'
version: 2021-10-18-preview
version-with-underscores: 2021_10_18_preview
input-file:
  - Microsoft.VideoIndexer/preview/2021-10-18-preview/vi.json
```
### Tag: package-2021-10-01-preview

These settings apply only when `--tag=2021-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-preview'
version: 2021-10-01-preview
version-with-underscores: 2021_10_01_preview
input-file:
  - Microsoft.VideoIndexer/preview/2021-10-01-preview/vi.json
```
### Tag: package-2021-09-01-preview

These settings apply only when `--tag=2021-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-09-01-preview'
version: 2021-09-01-preview
version-with-underscores: 2021_09_01_preview
input-file:
  - Microsoft.VideoIndexer/preview/2021-09-01-preview/vi.json
```
### Tag: package-2021-08-16-preview

These settings apply only when `--tag=2021-08-16-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-08-16-preview'
version: 2021-08-16-preview
version-with-underscores: 2021_08_16_preview
input-file:
  - Microsoft.VideoIndexer/preview/2021-08-16-preview/vi.json
```
### Tag: package-2021-08-01-preview

These settings apply only when `--tag=2021-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-08-01-preview'
version: 2021-08-01-preview
version-with-underscores: 2021_08_01_preview
input-file:
  - Microsoft.VideoIndexer/preview/2021-08-01-preview/vi.json
```
### Tag: package-2021-07-01-preview

These settings apply only when `--tag=2021-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-07-01-preview'
version: 2021-07-01-preview
version-with-underscores: 2021_07_01_preview
input-file:
  - Microsoft.VideoIndexer/preview/2021-07-01-preview/vi.json
```
### Tag: package-2021-04-01-preview

These settings apply only when `--tag=2021-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-04-01-preview'
version: 2021-04-01-preview
version-with-underscores: 2021_04_01_preview
input-file:
  - Microsoft.VideoIndexer/preview/2021-04-01-preview/vi.json
```


---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Node.js

See configuration in [readme.nodejs.md](./readme.nodejs.md)