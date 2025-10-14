# Deployment Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for Deployment Admin.

---

## Getting Started

To build the SDK for Deployment Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

## Configuration

### Basic Information
``` yaml
title: ApiManagementClient
description: ApiManagement Client
openapi-type: arm
tag: package-2019-01-01
```


### Tag: package-2019-01-01

```yaml $(tag) == 'package-2019-01-01'
input-file:
  - specs/2020-05-01/a.json
  - specs/2020-06-01/b.json
```


### Tag: package-2019-02

```yaml $(tag) == 'package-2019-01-01'
input-file:
```