# oep

> see https://aka.ms/autorest
This is the AutoRest configuration file for oep.
## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:
> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.
---

## Configuration

### Basic Information

These are the global settings for the oep.

```yaml
openapi-type: data-plane
tag: package-2021-06-01-preview
directive:
  - suppress: LongRunningResponseStatusCode
    reason: The validation tools do not properly recognize 202 as a supported response code.
```

### Tag: package-2021-06-01-preview

These settings apply only when `--tag=package-2021-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-06-01-preview'
input-file:
  - Microsoft.OpenEnergyPlatform/preview/2021-06-01-preview/storage.json
```