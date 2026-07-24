# DeploymentExtensionRuntimes

> see https://aka.ms/autorest

This is the AutoRest configuration file for the `Microsoft.Resources/deploymentExtensionRuntimes` resource provider.

## Getting Started

To build the SDKs, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings.

``` yaml
title: DeploymentExtensionRuntimesClient
description: DeploymentExtensionRuntimes Client
openapi-type: arm
tag: package-2026-10-01-preview
```

### Tag: package-2026-10-01-preview

These settings apply only when `--tag=package-2026-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2026-10-01-preview'
input-file:
  - preview/2026-10-01-preview/deploymentExtensionRuntimes.json
```

## Suppression

``` yaml
directive:
  - suppress: OperationsAPIImplementation
    from: deploymentExtensionRuntimes.json
    reason: Operations API is implemented as a separate service.
```
