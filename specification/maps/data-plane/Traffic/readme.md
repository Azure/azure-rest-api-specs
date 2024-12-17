# Azure Traffic

> see https://aka.ms/autorest

This is the AutoRest configuration file for Traffic Client

---

## Getting Started

To build the SDK for Traffic, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for Traffic Client.

``` yaml
title: TrafficClient
openapi-type: data-plane
tag: package-2025-01-01
# at some point those credentials will move away to Swagger according to [this](https://github.com/Azure/autorest/issues/3718)
add-credentials: true
credential-default-policy-type: BearerTokenCredentialPolicy
credential-scopes: https://atlas.microsoft.com/.default
```


### Tag: 1.0-preview

These settings apply only when `--tag=1.0-preview` is specified on the command line.

``` yaml $(tag) == '1.0-preview'
input-file:
  - preview/1.0/traffic.json
```

### Tag: package-2025-01-01

These settings apply only when `--tag=package-2025-01-01` is specified on the command line.

``` yaml $(tag) == 'package-2025-01-01'
input-file:
  - stable/2025-01-01/traffic.json

suppressions:
  - code: OperationIdNounVerb
    reason: False alarm. Per the Noun_Verb convention for Operation Ids, the noun 'Traffic' should not appear after the underscore.
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
