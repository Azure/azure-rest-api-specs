# Azure Search

> see https://aka.ms/autorest

This is the AutoRest configuration file for Search Client

---

## Getting Started

To build the SDK for Search, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for Search Client.

``` yaml
title: SearchClient
openapi-type: data-plane
tag: package-stable-2025-01-01
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

### Tag: package-stable-2025-01-01

These settings apply only when `--tag=package-stable-2025-01-01` is specified on the command line.

```yaml $(tag) == 'package-stable-2025-01-01'
input-file:
  - stable/2025-01-01/search.json
```

### Tag: package-stable-2023-06-01

These settings apply only when `--tag=package-stable-2023-06-01` is specified on the command line.

```yaml $(tag) == 'package-stable-2023-06-01'
input-file:
  - stable/2023-06-01/search.json
```

### Tag: package-2025-06-01-preview

These settings apply only when `--tag=package-2025-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-06-01-preview'
input-file:
  - preview/2025-06-01-preview/search.json
```

### Tag: package-retired-2024-04-01-preview

These settings apply only when `--tag=package-retired-2024-04-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-retired-2024-04-01-preview'
input-file:
  - preview/2024-04-01-preview/search.json
```

### Tag: package-retired-2022-12-01-preview

These settings apply only when `--tag=package-retired-2022-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-retired-2022-12-01-preview'
input-file:
  - preview/2022-12-01-preview/search.json
```

### Tag: package-retired-2022-09-01-preview

These settings apply only when `--tag=package-retired-2022-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-retired-2022-09-01-preview'
input-file:
  - preview/2022-09-01-preview/search.json
```

### Tag: package-retired-2022-02-01-preview

These settings apply only when `--tag=package-retired-2022-02-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-retired-2022-02-01-preview'
input-file:
  - preview/2022-02-01-preview/geocoding.json
```

### Tag: package-retired-2021-11-01-preview

These settings apply only when `--tag=package-retired-2021-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-retired-2021-11-01-preview'
input-file:
  - preview/2021-11-01-preview/geocoding.json
```

### Tag: package-stable-1.0

These settings apply only when `--tag=package-stable-1.0` is specified on the command line.

``` yaml $(tag) == 'package-stable-1.0'
input-file:
  - preview/1.0/search.json
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
