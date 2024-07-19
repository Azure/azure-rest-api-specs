# Azure Route

> see https://aka.ms/autorest

This is the AutoRest configuration file for Route Client

---

## Getting Started

To build the SDK for Route, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for Route Client.

``` yaml
title: RouteClient
openapi-type: data-plane
tag: package-preview-2024-07
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

### Tag: package-preview-2024-7

These settings apply only when `--tag=package-preview-2024-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-07'
input-file:
  - preview/2024-06-01-preview/route.json
  
suppressions:
  - code: OperationIdNounVerb
    reason: False alarm. Per the Noun_Verb convention for Operation Ids, the noun 'Route' should not appear after the underscore.
```

### Tag: package-preview-2024-6

These settings apply only when `--tag=package-preview-2024-06` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-06'
input-file:
  - preview/2024-06-01-preview/route.json
  
suppressions:
  - code: OperationIdNounVerb
    reason: False alarm. Per the Noun_Verb convention for Operation Ids, the noun 'Route' should not appear after the underscore.
```

### Tag: package-preview-2024-5

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - preview/2024-05-01-preview/route.json

suppressions:
  - code: OperationIdNounVerb
    reason: False alarm. Per the Noun_Verb convention for Operation Ids, the noun 'Route' should not appear after the underscore.
```

### Tag: package-preview-2024-04

These settings apply only when `--tag=package-preview-2024-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-04'
input-file:
  - preview/2024-04-01-preview/route.json
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-10'
input-file:
  - preview/2023-10-01-preview/route.json
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-09'
input-file:
  - preview/2023-09-01-preview/route.json
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - preview/2023-08-01-preview/route.json
```

### Tag: 1.0

These settings apply only when `--tag=1.0` is specified on the command line.

``` yaml $(tag) == '1.0'
input-file:
  - preview/1.0/route.json
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
