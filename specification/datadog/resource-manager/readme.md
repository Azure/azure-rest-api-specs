# Datadog

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerInstance.



---
## Getting Started
To build the SDK for Datadog, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Datadog API.

``` yaml
title: Microsoft Datadog Client
openapi-type: arm
tag: package-2020-02-preview
```

### Tag: package-2020-02-preview

These settings apply only when `--tag=package-2020-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-02-preview'
input-file:
- Microsoft.Confluent/preview/2020-02-01-preview/datadog.json
```
