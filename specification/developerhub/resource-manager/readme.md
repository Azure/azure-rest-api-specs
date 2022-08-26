# DeveloperHub

> see https://aka.ms/autorest

This is the AutoRest configuration file for DeveloperHub.

## Getting Started

To build the SDKs for the DeveloperHub API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the DeveloperHub API.

```yaml
openapi-type: arm
tag: package-preview-2022-04
```

### Tag: package-preview-2022-04

These settings apply only when `--tag=package-preview-2022-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-04'
input-file:
  - Microsoft.DevHub/preview/2022-04-01-preview/workflow.json
```
