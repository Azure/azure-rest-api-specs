# Azure Data

> see https://aka.ms/autorest

This is the AutoRest configuration file for Data Client

---

## Getting Started

To build the SDK for Data, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for Data Registry Client.

``` yaml
title: DataRegistryClient
openapi-type: data-plane
tag: 2023-06-01
# at some point those credentials will move away to Swagger according to [this](https://github.com/Azure/autorest/issues/3718)
add-credentials: true
credential-default-policy-type: BearerTokenCredentialPolicy
credential-scopes: https://atlas.microsoft.com/.default
```

### Tag: 2023-06-01

These settings apply only when `--tag=2023-06-01` is specified on the command line.

``` yaml $(tag) == '2023-06-01'
input-file:
  - stable/2023-06-01/dataregistry.json
```

### Tag: 2022-12-01

These settings apply only when `--tag=2022-12-01-preview` is specified on the command line.

``` yaml $(tag) == '2022-12-01-preview'
input-file:
  - preview/2022-12-01-preview/dataregistry.json
```

# Code Generation
