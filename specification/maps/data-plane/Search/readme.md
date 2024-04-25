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
tag: package-2023-06
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


### Tag: package-2023-06

These settings apply only when `--tag=package-2023-06` is specified on the command line.

```yaml $(tag) == 'package-2023-06'
input-file:
  - stable/2023-06-01/search.json
```
### Tag: 1.0

These settings apply only when `--tag=1.0` is specified on the command line.

``` yaml $(tag) == '1.0'
input-file:
  - preview/1.0/search.json
```

### Tag: 2.0-preview

These settings apply only when `--tag=2021-11-01-preview` is specified on the command line.

``` yaml $(tag) == '2021-11-01-preview'
input-file:
  - preview/2021-11-01-preview/geocoding.json
```

### Tag: 2.1-preview

These settings apply only when `--tag=2022-02-01-preview` is specified on the command line.

``` yaml $(tag) == '2022-02-01-preview'
input-file:
  - preview/2022-02-01-preview/geocoding.json
```

### Tag: package-preview-2022-09

These settings apply only when `--tag=package-preview-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-09'
input-file:
  - preview/2022-09-01-preview/search.json
```

### Tag: package-preview-2022-12

These settings apply only when `--tag=package-preview-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-12'
input-file:
  - preview/2022-12-01-preview/search.json
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
