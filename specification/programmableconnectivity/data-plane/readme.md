# Azure Programmable Connectivity

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Programmable Connectivity.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Azure Programmable Connectivity.

```yaml
openapi-type: data-plane
tag: package-v2024_01_09_preview
title: AzureProgrammableConnectivity
```

### Tag: package-v2024_01_09_preview

These settings apply only when `--tag=package-v2024_01_09_preview` is specified on the command line.

```yaml $(tag) == 'package-v2024_01_09_preview'
input-file:
  - Azure.ProgrammableConnectivity/preview/v2024_01_09_preview/openapi.json
```