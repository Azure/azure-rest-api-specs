# M365

> see https://aka.ms/autorest

This is the AutoRest configuration file for m365.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the m365.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2022-08-31-privatepreview
```

### Tag: package-2022-08-31-privatepreview

These settings apply only when `--tag=package-2022-08-31-privatepreview` is specified on the command line.

```yaml $(tag) == 'package-2022-08-31-privatepreview'
title: M365ResourcesClient
description: M365 Resource Client
input-file:
- Microsoft.M365/preview/2022-08-31-privatepreview/m365.json
- Microsoft.M365/preview/2022-08-31-privatepreview/m365Operations.json
```
