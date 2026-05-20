# Microsoft.FoundryLocal

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Microsoft.FoundryLocal Resource Provider.

---
## Getting Started

To build the SDKs for the Microsoft.FoundryLocal API, simply install AutoRest via `npm` (`npm install -g autorest`) and run:
> `autorest readme.md`

To see additional help and options, run:
> `autorest --help`

---
## Configuration

### Basic Information

```yaml
openapi-subtype: rpaas
title: FoundryLocalManagementClient
description: The Microsoft.FoundryLocal resource provider.
openapi-type: arm
tag: package-2026-05-20-preview
```

### Tag: package-2026-05-20-preview

These settings apply only when `--tag=package-2026-05-20-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-05-20-preview'
input-file:
  - Microsoft.FoundryLocal/preview/2026-05-20-preview/modelDeployments.json
```
