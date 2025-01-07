# workloads

> see https://aka.ms/autorest

This is the AutoRest configuration file for workloads.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the workloads.

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2025-01
```


### Tag: package-preview-2025-01

These settings apply only when `--tag=package-preview-2025-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-01'
title: Workloads Client
input-file:
  - ConfigurationChecksTemplate.json
  - examples/ConfigurationChecksTemplate_Get.json
  - examples/ConfigurationChecksTemplate_ListByResourceGroup.json