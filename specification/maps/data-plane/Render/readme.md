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
title: RenderClient
openapi-type: data-plane
tag: 2.1 # removed "preview" as it started causing validation errors from v0.26 of the Swagger Lintdiff.
# at some point those credentials will move away to Swagger according to [this](https://github.com/Azure/autorest/issues/3718)
add-credentials: true
credential-default-policy-type: BearerTokenCredentialPolicy
credential-scopes: https://atlas.microsoft.com/.default
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

### Tag: 2022-08-01

These settings apply only when `--tag=2022-08-01` is specified on the command line.
``` yaml $(tag) == '2022-08-01'
input-file:
  - stable/2022-08-01/render.json
```

### Tag: 2.1-preview

These settings apply only when `--tag=2.1` is specified on the command line.

``` yaml $(tag) == '2.1'
input-file:
  - preview/2.1/render.json
```

### Tag: 2.0-preview

These settings apply only when `--tag=2.0` is specified on the command line.

``` yaml $(tag) == '2.0'
input-file:
  - preview/2.0/render.json
```

### Tag: 1.0-preview

These settings apply only when `--tag=1.0` is specified on the command line.

``` yaml $(tag) == '1.0'
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
