# Experimentation

> see https://aka.ms/autorest

This is the AutoRest configuration file for Experimentation

## Getting Started

To build the SDKs for Experimentation, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Experimentation.

```yaml
title: Azure ExP Data Plane
openapi-type: data-plane
```


### Tag: package-2024-11-30-preview

These settings apply only when `--tag=package-2024-11-30-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-11-30-preview'
input-file:
  - Microsoft.Experimentation/preview/2024-11-30-preview/experimentation.json
```
