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
# The Azure Maps Traffic service v1.0 will be retired on March 31, 2028
title: TrafficClient
openapi-type: data-plane
tag: package-stable-2025-01-01
# at some point those credentials will move away to Swagger according to [this](https://github.com/Azure/autorest/issues/3718)
add-credentials: true
credential-default-policy-type: BearerTokenCredentialPolicy
credential-scopes: https://atlas.microsoft.com/.default
```

### Suppression

``` yaml
directive:
  - suppress: OperationIdNounVerb
    reason: Fixing this risks introducing breaking changes.
```

### Tag: package-deprecated-1.0

These settings apply only when `--tag=package-deprecated-1.0` is specified on the command line.

``` yaml $(tag) == 'package-deprecated-1.0'
input-file:
  - stable/1.0/traffic.json
```

### Tag: package-stable-2025-01-01

These settings apply only when `--tag=package-stable-2025-01-01` is specified on the command line.

``` yaml $(tag) == 'package-stable-2025-01-01'
input-file:
  - stable/2025-01-01/traffic.json
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
