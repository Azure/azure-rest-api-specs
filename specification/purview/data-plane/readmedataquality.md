see https://aka.ms/autorest

This is the AutoRest configuration file for Purview.

---

## Getting Started

To build the SDK for Purview, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

``` yaml
openapi-type: data-plane
tag: package-2025-09-01-preview
title: PurviewDataQuality
```

tag: package-2022-09-01-preview
title: PurviewDataQualityClient

### Tag: package-2025-09-01-preview

``` yaml $(tag) == 'package-2025-09-01-preview'
input-file:
- ./Azure.Analytics.Purview.DataQuality/preview/2025-09-01-preview/purviewDataQuality.json
modelerfour:
  lenient-model-deduplication: true
```
