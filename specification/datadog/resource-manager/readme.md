# Datadog

> see https://aka.ms/autorest

This is the AutoRest configuration file for Datadog.



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
title: DatadogManagementClient
openapi-type: arm
openapi-subtype: rpaas
tag: package-2020-02-01-preview
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
- Microsoft.Datadog/stable/2021-03-01/swagger.json
```

### Tag: package-2020-02-01-preview

These settings apply only when `--tag=package-2020-02-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-02-01-preview'
input-file:
- Microsoft.Datadog/preview/2020-02-01-preview/swagger.json
```

### Tag: package-2022-06-01

These settings apply only when `--tag=package-2022-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-06-01'
input-file:
- Microsoft.Datadog/stable/2022-06-01/swagger.json
```

### Tag: package-2022-08-01

These settings apply only when `--tag=package-2022-08-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-08-01'
input-file:
- Microsoft.Datadog/stable/2022-08-01/swagger.json
```
