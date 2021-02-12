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

### Suppression

``` yaml
directive:
  - suppress: R3016
    from: mr-sts.json
    where: $.definitions.StsTokenResponseMessage.properties.AccessToken
    reason: The API is already public and changing the casing will involve a breaking change.
```
### Basic Information

These are the global settings for Azure Mixed Reality Client.

```yaml
title: MixedRealityRemoteRendering
openapi-type: data-plane
tag: package-2021-01-01-preview
```

### Tag: package-2021-01-01-preview

These settings apply only when `--tag=package-2021-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-01-preview'
input-file:
- Microsoft.MixedReality/preview/2021-01-01-preview/mr-arr.json
```

### Tag: package-2019-02-28-preview

These settings apply only when `--tag=package-2019-02-28-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-02-28-preview'
input-file:
- Microsoft.MixedReality/preview/2019-02-28-preview/mr-sts.json
```
