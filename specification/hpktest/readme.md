# [[hpktest]]

> see https://aka.ms/autorest

This is the AutoRest configuration file for [[hpktest]].

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the [hpktest].

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-09-01
```

### Tag: package-[2024-09-01]

These settings apply only when `--tag=package-[2024-09-01]` is specified on the command line.

```yaml $(tag) == 'package-[2024-09-01]'
input-file:
  - resource-manager/Microsoft.HpkTest/2024-09-01/hpktest.json
```
