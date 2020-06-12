# Confluent

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerInstance.



---
## Getting Started
To build the SDK for ContainerInstance, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Confluent API.

``` yaml
title: Microsoft Confluent Client
openapi-type: arm
tag: package-2020-03-preview
```

### Tag: package-2020-03-preview

These settings apply only when `--tag=package-2020-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-preview'
input-file:
- Microsoft.Confluent/preview/2020-03-01-preview/confluent.json
```
