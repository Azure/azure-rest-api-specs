# DependencyMap

> see https://aka.ms/autorest

This is the AutoRest configuration file for Dependency Map resource provider.

## Getting Started

To build the SDKs for DependencyMap API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Dependency Map RP.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-05-01-preview
```

### Tag: package-2025-01-31-preview

These settings apply only when `--tag=package-2025-01-31-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-01-31-preview'
input-file:
  - Microsoft.DependencyMap/preview/2025-01-31-preview/dependencyMap.json
```

### Tag: package-2025-05-01-preview

These settings apply only when `--tag=package-2025-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-05-01-preview'
input-file:
  - Microsoft.DependencyMap/preview/2025-05-01-preview/dependencyMap.json
```
