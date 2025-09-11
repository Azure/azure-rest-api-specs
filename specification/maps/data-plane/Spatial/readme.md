# Azure Spatial

> see https://aka.ms/autorest

This is the AutoRest configuration file for Spatial Client

---

## Getting Started

To build the SDK for Spatial, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for Spatial Client.

``` yaml
# Azure Maps Spatial v2022-08-01 has been deprecated and will be retired on September 30th, 2025.
title: SpatialClient
openapi-type: data-plane
tag: package-stable-deprecated-2022-08-01
# at some point those credentials will move away to Swagger according to [this](https://github.com/Azure/autorest/issues/3718)
add-credentials: true
credential-default-policy-type: BearerTokenCredentialPolicy
credential-scopes: https://atlas.microsoft.com/.default
```


### Tag: package-stable-deprecated-2022-08-01

These settings apply only when `--tag=package-stable-deprecated-2022-08-01` is specified on the command line.

``` yaml $(tag) == 'package-stable-deprecated-2022-08-01'
input-file:
  - stable/2022-08-01/spatial.json
```

# Code Generation
