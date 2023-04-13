# API Management Developer Services Data Plane Client

> see https://aka.ms/autorest

This is the AutoRest configuration file for API Management Developer Services Data Plane Client.

---

## Getting Started

To build the SDKs for Developer Services API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Developer Services API.

```yaml
openapi-type: default
tag: package-2022-04-01-preview
```

### Tag: package-2022-04-01-preview

These settings apply only when `--tag=package-2022-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-04-01-preview'
input-file:
- DeveloperServicesPublicAPI/preview/2022-04-01-preview/azure.apimanagement.developerservicesapi.json
- DeveloperServicesAuthorizedAPI/preview/2022-04-01-preview/azure.apimanagement.developerservicesapi.json
```