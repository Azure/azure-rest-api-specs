# identitygovernance

> see https://aka.ms/autorest

This is the AutoRest configuration file for identitygovernance.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the identitygovernance.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-06-13-preview
```

### Tag: package-2025-06-13-preview

These settings apply only when `--tag=package-2025-06-13-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-06-13-preview'
input-file:
  - Microsoft.EntraidGovernance/preview/2025-06-13-preview/openapi.json
```

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-02-01-preview
```

### Tag: package-2025-02-01-preview

These settings apply only when `--tag=package-2025-02-01-preview` is specified on the command lines.

```yaml $(tag) == 'package-2025-02-01-preview'
input-file:
  - Microsoft.EntraidGovernance/preview/2025-02-01-preview/openapi.json
```
