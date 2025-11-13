# Links

> see https://aka.ms/autorest

This is the AutoRest configuration file.

## Getting Started

To build the SDK for Resource, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Resource API.

``` yaml
title: ManagementLinkClient
description: ManagementLink Client
openapi-type: arm
tag: package-resources-2025-04
```

### Tag: package-links-2016-09

These settings apply only when `--tag=package-links-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-links-2016-09'
input-file:
- stable/2016-09-01/links.json
```
