# Azure Creator

> see https://aka.ms/autorest

This is the AutoRest configuration file for Creator Client

---

## Getting Started

To build the SDK for Creator, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for Creator Client.

``` yaml
title: CreatorClient
openapi-type: data-plane
tag: package-2023-07
add-credentials: true
credential-default-policy-type: BearerTokenCredentialPolicy
credential-scopes: 'https://atlas.microsoft.com/.default'
```

### Tag: package-stable-V2

These settings apply only when `--tag=package-V2` is specified on the command line.

```yaml $(tag) == 'package-2023-07'
input-file:
  - Creator/preview/2.0/alias.json
  - Creator/preview/2.0/dataset.json
  - Creator/preview/2.0/dwgconversion.json
  - Creator/preview/2.0/featurestate.json
  - Creator/preview/2.0/tileset.json
  - Creator/preview/2.0/wfs.json

```

### Tag: package-preview-2023-03

These settings apply only when `--tag=package-preview-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-03'
input-file:
  - Creator/preview/2023-03-01-preview/alias.json
  - Creator/preview/2023-03-01-preview/dataset.json
  - Creator/preview/2023-03-01-preview/dwgconversion.json
  - Creator/preview/2023-03-01-preview/features.json
  - Creator/preview/2023-03-01-preview/featurestate.json
  - Creator/preview/2023-03-01-preview/mapconfiguration.json
  - Creator/preview/2023-03-01-preview/routeset.json
  - Creator/preview/2023-03-01-preview/style.json
  - Creator/preview/2023-03-01-preview/tileset.json
  - Creator/preview/2023-03-01-preview/wayfind.json
```

## Code Generation

### Python

See configuration in [readme.python.md](./readme.python.md)

### Java

See configuration in [readme.java.md](./readme.java.md)

### TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

### CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

### Go

See configuration in [readme.go.md](./readme.go.md)
