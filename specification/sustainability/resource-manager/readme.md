# Sustainability

> see https://aka.ms/autorest

This is the AutoRest configuration file for Sustainability.



---
## Getting Started
To build the SDK for Sustainability, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`
---

## Configuration


### Basic Information
These are the global settings for the Azure Sphere API.

``` yaml
title: Sustainability
openapi-type: arm
openapi-subtype: rpaas
tag: package-2023-04-01-preview
```

### Tag: package-2023-04-01-preview

These settings apply only when `--tag=package-2023-04-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-04-01-preview'
input-file:
- Microsoft.Sustainability/preview/2023-04-01-preview/main.json
```
