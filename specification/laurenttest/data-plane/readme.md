# laurenttest

> see https://aka.ms/autorest

This is the AutoRest configuration file for laurenttest.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the laurenttest.

```yaml
openapi-type: data-plane
tag: package-2021-06-04
```

### Tag: package-2021-06-04

These settings apply only when `--tag=package-2021-06-04` is specified on the command line.

```yaml $(tag) == 'package-2021-06-04'
input-file:
  - Microsoft.FrenchTest/preview/2021-06-04/laurenttest.json
```
