# throttling

> see https://aka.ms/autorest

This is the AutoRest configuration file for Throttling.

## Getting Started

To build the SDKs for Throttling, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for Throttling.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-03-01-preview
```

### Tag: package-2025-03-01-preview

These settings apply only when `--tag=package-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-preview'
input-file:
  - Microsoft.Throttling/preview/2025-03-01-preview/throttling.json
suppressions:    
  - code: GuidUsage
    from: throttling.json
    where: $.definitions["Azure.Core.uuid"].format
    reason: Properties represent Entra ID Tenant Id and Object ID which are always a Guid
```
```

---

# Code Generation
