# Grip

> see https://aka.ms/autorest
This is the AutoRest configuration file for Grip.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Grip.

```yaml
openapi-type: arm
openapi-subtype: providerHub
tag: package-2023-07-13
```

### Tag: package-2023-07-13

These settings apply only when `--tag=package-2023-07-13` is specified on the command line.

```yaml $(tag) == 'package-2023-07-13'
input-file:
  - Microsoft.Grip/stable/2023-07-13/openapi.json