# Azure Geocoding

> see https://aka.ms/autorest

This is the AutoRest configuration file for Geocoding Client

---

## Getting Started

To build the SDK for Geocoding, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for Geocoding Client.

``` yaml
title: GeocodingClient
openapi-type: data-plane
tag: 1.0-preview
# at some point those credentials will move away to Swagger according to [this](https://github.com/Azure/autorest/issues/3718)
add-credentials: true
credential-default-policy-type: BearerTokenCredentialPolicy
credential-scopes: https://atlas.microsoft.com/.default
```


### Tag: 1.0-preview

These settings apply only when `--tag=1.0-preview` is specified on the command line.

``` yaml $(tag) == '1.0-preview'
input-file:
  - preview/2021-11-01-preview/geocoding.json
```


