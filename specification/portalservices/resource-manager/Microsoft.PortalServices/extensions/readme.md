# portal

> see https://aka.ms/autorest

This is the AutoRest configuration file for portal.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the portal.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-11-01
```

### Tag: package-2025-11-01

These settings apply only when `--tag=package-2025-11-01` is specified on the command line.

```yaml $(tag) == 'package-2025-11-01'
input-file:
  - stable/2025-11-01/extensions.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: >
      The CompileFile resource models use Record<unknown> types for flexible content payloads
      (file contents, compile results). These are existing API contracts from preview that
      cannot be changed without breaking compatibility.
    from:
      - extensions.json
  - code: PostResponseCodes
    reason: >
      The CompileFile operation is a synchronous POST action that returns 200 with a result body.
      This is an existing API contract from preview that follows a synchronous request-response pattern,
      not a long-running operation.
    from:
      - extensions.json
```

### Tag: package-2024-04-01-preview

These settings apply only when `--tag=package-2024-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-04-01-preview'
input-file:
  - preview/2024-04-01-preview/extensions.json
```

### Tag: package-2023-01-01-preview

These settings apply only when `--tag=package-2023-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-01-01-preview'
input-file:
  - preview/2023-01-01-preview/extensions.json
```

---

# Code Generation
