# Titan

> see https://aka.ms/autorest
This is the AutoRest configuration file for Titan.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the properties for a compute device resource.

```yaml
openapi-type: arm
openapi-subtype: providerHub
tag: package-2024-06-24-preview
```

### Tag: package-2024-06-24-preview

These settings apply only when `--tag=package-2024-06-24-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-06-24-preview'
input-file:
  - Microsoft.Titan/preview/2024-06-24-preview/titan.json
```

## Suppression

``` yaml
directive:
  - suppress: BodyTopLevelProperties
    from: titan.json
    reason: Issue https://github.com/Azure/azure-openapi-validator/issues/722. The BodyTopLevelProperties check failing.

  - suppress: OBJECT_ADDITIONAL_PROPERTIES
    from: titan.json
    reason: Adding location and tags as top level property. Suppressing tooling gap.
```
