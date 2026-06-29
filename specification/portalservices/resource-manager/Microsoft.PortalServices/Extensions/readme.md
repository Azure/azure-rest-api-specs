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
      The CompileFile API is intentionally schemaless by design. It accepts arbitrary
      user JSON content for compilation (`contents`, `stringSource`, `files` — typically
      extension/blade definitions or configuration payloads) and returns a compiled result
      whose shape depends entirely on the input. No fixed schema can describe these payloads
      because the service exists precisely to accept user-defined content; this is a genuine
      schemaless data requirement, not a backward-compatibility constraint.
    from:
      - extensions.json
  - code: PostResponseCodes
    reason: >
      CompileFile is a genuinely synchronous action — compilation completes inline and
      returns the result in the response body. It is not, and was never intended to be,
      a long-running operation, so a 200 response with a result body is the correct shape.
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
