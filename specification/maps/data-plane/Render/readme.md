# Azure Render

> see https://aka.ms/autorest

This is the AutoRest configuration file for Render Client

---

## Getting Started

To build the SDK for Render, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for Render Client.

``` yaml
## Azure Maps Render 1.0 has been deprecated and will be retired on 17 September 2026.
## Azure Maps Render 2.0 & 2.1 - The endpoint might be used by WebSDK V2.2x or older. Neither should appear in the TOC.
title: RenderClient
openapi-type: data-plane
tag: package-stable-2024-04-01
add-credentials: true
credential-default-policy-type: BearerTokenCredentialPolicy
credential-scopes: 'https://atlas.microsoft.com/.default'
track2: true
verbose: true
sdk-integration: true
modelerfour:
  additional-checks: false
  lenient-model-deduplication: true
```

### Suppression

``` yaml
directive:
  - suppress: INVALID_TYPE
    reason: false positive from oav is breaking our example validation. See azure/oav#1021.
```


### Tag: package-stable-2024-04-01

These settings apply only when `--tag=package-stable-2024-04-01` is specified on the command line.

```yaml $(tag) == 'package-stable-2024-04-01'
input-file:
  - stable/2024-04-01/render.json
```
### Tag: package-stable-2022-08-01

These settings apply only when `--tag=package-stable-2022-08-01` is specified on the command line.

``` yaml $(tag) == 'package-stable-2022-08-01'
input-file:
  - stable/2022-08-01/render.json
```

### Tag: package-stable-2.1

These settings apply only when `--tag=package-stable-2.1` is specified on the command line.

``` yaml $(tag) == 'package-stable-2.1'
input-file:
  - preview/2.1/render.json
```

### Tag: package-stable-2.0

These settings apply only when `--tag=package-stable-2.0` is specified on the command line.

``` yaml $(tag) == 'package-stable-2.0'
input-file:
  - preview/2.0/render.json
```

### Tag: package-deprecated-1.0

These settings apply only when `--tag=package-deprecated-1.0` is specified on the command line.

``` yaml $(tag) == 'package-deprecated-1.0'
input-file:
  - preview/1.0/render.json
```

# Code Generation

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Go

See configuration in [readme.go.md](./readme.go.md)
