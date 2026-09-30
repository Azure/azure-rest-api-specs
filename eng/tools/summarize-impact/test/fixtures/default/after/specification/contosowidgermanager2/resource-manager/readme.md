# contosowidgermanager 2

> see https://aka.ms/autorest
This is the AutoRest configuration file for Contoso.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

```yaml
suppressions:
  - code: AvoidAnonymousTypes
```

### Basic Information

These are the global settings for the containerstorage.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2021-11-01
```

### Tag: package-2021-11-01

These settings apply only when `--tag=package-2021-11-01` is specified on the command line.

```yaml $(tag) == 'package-2021-11-01'
input-file:
  - Microsoft.Contoso/stable/2021-11-01/contoso.json
```

---
