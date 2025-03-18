# communicationservices

> see https://aka.ms/autorest

This is the AutoRest configuration file for communicationservices.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the communicationservices.

```yaml
openapi-type: data-plane
tag: package-2024-02-01
```

### Tag: package-2024-02-01

These settings apply only when `--tag=package-2024-02-01` is specified on the command line.

```yaml $(tag) == 'package-2024-02-01'
input-file:
  - stable/2024-02-01/communicationservicesmessages.json
title:
  Azure Communication Services
```

### Tag: package-2023-08-24-preview

These settings apply only when `--tag=package-2023-08-24-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-08-24-preview'
input-file:
  - preview/2023-08-24-preview/CommunicationServicesMessages.json
title:
  Azure Communication Services
```

``` yaml
suppressions:
  - code: LroExtension
```