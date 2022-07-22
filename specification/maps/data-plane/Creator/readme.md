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
tag: package-preview-2022-09
add-credentials: true
credential-default-policy-type: BearerTokenCredentialPolicy
credential-scopes: 'https://atlas.microsoft.com/.default'
```


### Tag: package-preview-2022-09

These settings apply only when `--tag=package-preview-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-09'
input-file:
  - preview/2022-09-01-preview/tileset.json
  - preview/2022-09-01-preview/style.json
  - preview/2022-09-01-preview/mapconfiguration.json
  - preview/2.0/alias.json
  - preview/2.0/data.json
  - preview/2.0/dataset.json
  - preview/2.0/dwgconversion.json
  - preview/2.0/featurestate.json
  - preview/2.0/wfs.json
```
### Tag: 2.0-preview
# at some point those credentials will move away to Swagger according to [this](https://github.com/Azure/autorest/issues/3718)
These settings apply only when `--tag=2.0-preview` is specified on the command line.

``` yaml $(tag) == '2.0-preview'
input-file:
  - preview/2.0/alias.json
  - preview/2.0/data.json
  - preview/2.0/dataset.json
  - preview/2.0/dwgconversion.json
  - preview/2.0/featurestate.json
  - preview/1.0/spatial.json
  - preview/2.0/tileset.json
  - preview/2.0/wfs.json
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
