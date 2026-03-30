# AgentDevCompute

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.App Agent Dev Compute service.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Agent Dev Compute.

``` yaml
openapi-type: arm
tag: package-2026-02-01-preview

suppressions:
  - code: OperationsAPIImplementation
    reason: The operations API is defined in a separate file.
    from: agentdevcompute.json
```

### Tag: package-2026-02-01-preview

These settings apply only when `--tag=package-2026-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-02-01-preview'
input-file:
  - preview/2026-02-01-preview/agentdevcompute.json
```
