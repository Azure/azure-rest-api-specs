# DevCompute

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.App Dev Compute service.

## Getting Started

To build the SDKs for DevCompute, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest GitHub page.

---

## Configuration

### Basic Information

These are the global settings for Dev Compute.

``` yaml
openapi-type: arm
tag: package-2026-07-01

suppressions:
  - code: OperationsAPIImplementation
    reason: >-
      Microsoft.App is a single ARM provider namespace split across multiple
      specification folders. The tenant-scoped /providers/Microsoft.App/operations
      endpoint is defined once in the ContainerApps swagger
      (ContainerApps/preview/2025-10-02-preview/openapi.json) and serves all
      operations under Microsoft.App, including sandboxGroups and vnetConnections.
      Re-declaring the endpoint here would cause duplicate path / operationId
      conflicts in the combined RP view.
    from: devcompute.json
```

### Tag: package-2026-07-01

These settings apply only when `--tag=package-2026-07-01` is specified on the command line.

```yaml $(tag) == 'package-2026-07-01'
input-file:
  - stable/2026-07-01/devcompute.json
```
