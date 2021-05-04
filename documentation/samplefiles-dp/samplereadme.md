# [[ServiceName]]

> see https://aka.ms/autorest

This is the AutoRest configuration file for [[ServiceName]].

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the [[ServiceName]].

```yaml
openapi-type: [[OpenApiType]]
tag: package-[[Version]]
```

### Tag: package-[[Version]]

These settings apply only when `--tag=package-[[Version]]` is specified on the command line.

```yaml $(tag) == 'package-[[Version]]'
input-file:
  - [[ResourceProviderName]]/[[ReleaseState]]/[[Version]]/[[ServiceName]].json
```
