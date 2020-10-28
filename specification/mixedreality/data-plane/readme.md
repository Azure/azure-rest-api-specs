# Mixed Reality

> see https://aka.ms/autorest

This is the AutoRest configuration file for Mixed Reality.

## Getting Started

To build the SDKs for this API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for Azure Mixed Reality STS.

```yaml
title: MixedRealityStsClient
openapi-type: data-plane
tag: package-2019-02-28-preview
```

### Tag: package-2019-02-28-preview

These settings apply only when `--tag=package-2019-02-28-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-02-28-preview'
input-file:
- Microsoft.MixedReality/preview/2019-02-28-preview/mr-sts.json
```