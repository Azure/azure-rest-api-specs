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

### Suppression

``` yaml
directive:
  - suppress: IntegerTypeMustHaveFormat
    reason: Data-plane specs can suppress violations of this rule, since it only exists for the benefit of SDKs generated from swagger, and data-plane SDKs are generated directly from TypeSpec (https://github.com/Azure/azure-rest-api-specs/wiki/Swagger-LintDiff#integertypemusthaveformat).

  - suppress: OperationIdNounVerb
    reason: Fixing this risks introducing breaking changes.
```

### Tag: package-stable-2025-01-01

These settings apply only when `--tag=package-stable-2025-01-01` is specified on the command line.

```yaml $(tag) == 'package-stable-2025-01-01'
input-file:
  - stable/2025-01-01/route.json

suppressions:
  - code: OperationIdNounVerb
    reason: False alarm. Per the Noun_Verb convention for Operation Ids, the noun 'Route' should not appear after the underscore.
```

### Tag: package-2024-07-01-preview

These settings apply only when `--tag=package-2024-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-07-01-preview'
input-file:
  - preview/2024-07-01-preview/route.json
  
suppressions:
  - code: OperationIdNounVerb
    reason: False alarm. Per the Noun_Verb convention for Operation Ids, the noun 'Route' should not appear after the underscore.
```

### Tag: package-2024-04-01-preview

These settings apply only when `--tag=package-2024-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-04-01-preview'
input-file:
  - preview/2024-04-01-preview/route.json
```

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-10-01-preview'
input-file:
  - preview/2023-10-01-preview/route.json
```

### Tag: package-stable-deprecated-1.0

These settings apply only when `--tag=package-stable-deprecated-1.0` is specified on the command line.

``` yaml $(tag) == 'package-stable-deprecated-1.0'
input-file:
  - stable/1.0/route.json
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
