# Device Provisioning Service

> see https://aka.ms/autorest

This is the AutoRest configuration file for Device Provisioning Service.

---

## Getting Started

To build the SDK for Device Provisioning Service, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the IotHub API.

``` yaml
openapi-type: arm
tag: package-2021-10-01
```


### Tag: package-2021-10-01

These settings apply only when `--tag=package-2021-10-01` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01'
input-file:
  - stable/2021-10-01/service.json
```
---

# Code Generation

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)
