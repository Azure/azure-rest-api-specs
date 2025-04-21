# Carbon

> see https://aka.ms/autorest

This is the AutoRest configuration file for Carbon.



---
## Getting Started
To build the SDK for Carbon, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`
---

## Configuration


### Basic Information
These are the global settings for the Carbon Optimization API.

``` yaml
title: CarbonOptimizationClient
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-04-01-beta
```


### Tag: package-2025-04-01-beta

These settings apply only when `--tag=package-2025-04-01-beta` is specified on the command line.

``` yaml $(tag) == 'package-2025-04-01-beta'
input-file:
- Microsoft.Carbon/stable/2025-04-01/main.json
```
