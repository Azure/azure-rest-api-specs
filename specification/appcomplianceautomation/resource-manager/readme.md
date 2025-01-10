# appcomplianceautomation

> see https://aka.ms/autorest

This is the AutoRest configuration file for appcomplianceautomation.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the appcomplianceautomation.

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-06
```


### Tag: package-2024-06

These settings apply only when `--tag=package-2024-06` is specified on the command line.

```yaml $(tag) == 'package-2024-06'
input-file:
  - Microsoft.AppComplianceAutomation/stable/2024-06-27/appcomplianceautomation.json
```
### Tag: package-2022-11-16-preview

These settings apply only when `--tag=package-2022-11-16-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-11-16-preview'
input-file:
  - Microsoft.AppComplianceAutomation/preview/2022-11-16-preview/appcomplianceautomation.json
```

---

# Code Generation
