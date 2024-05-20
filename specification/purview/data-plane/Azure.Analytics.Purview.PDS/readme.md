# Purview

> see https://aka.ms/autorest

This is the AutoRest configuration file for Purview Distribution Service.

---

## Getting Started

To build the SDK for Purview Distribution Service, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Purview Distribution Service API.

``` yaml
openapi-type: data-plane
tag: package-2023-01-01
title: PurviewPDSClient
```

### Tag: package-2022-11-01-preview

These settings apply only when `--tag=package-2022-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-11-01-preview'
input-file:
- preview/2022-11-01-preview/pds.json
```

### Tag: package-2023-01-01

These settings apply only when `--tag=package-2023-01-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-01-01'
input-file:
- stable/2023-01-01/pds.json
```
