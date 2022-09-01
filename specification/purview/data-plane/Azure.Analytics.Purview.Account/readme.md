# Purview

> see https://aka.ms/autorest

This is the AutoRest configuration file for Purview Account Service.

---

## Getting Started

To build the SDK for Purview Account Service, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information
These are the global settings for the Azure Purview Account API.

``` yaml
openapi-type: data-plane
tag: package-2019-11-01-preview
title: PurviewAccountClient
```


### Tag: package-2019-11-01-preview

These settings apply only when `--tag=package-2019-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-01-preview'
input-file:
- preview/2019-11-01-preview/account.json
```
