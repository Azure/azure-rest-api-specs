# Microsoft.NetworkSecurity NeuroShield

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Microsoft.NetworkSecurity NeuroShield management service.

## TypeSpec

This project defines `2026-10-01-preview`. Edit the TypeSpec source and examples
under `examples/2026-10-01-preview`, then regenerate the OpenAPI and mirrored
examples from this directory:

```text
pnpm exec tsp compile . --warn-as-error
```

Commit the generated files under `preview/2026-10-01-preview` together with the
source changes. Do not edit the generated OpenAPI directly.

## Getting Started

To build the SDKs for Microsoft.NetworkSecurity NeuroShield, install AutoRest via `npm` and run:

> `autorest readme.md`

## Configuration

### Basic Information

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-10-01-preview
```

### Tag: package-2026-10-01-preview

These settings apply when `--tag=package-2026-10-01-preview` is specified.

```yaml $(tag) == 'package-2026-10-01-preview'
input-file:
  - preview/2026-10-01-preview/neuroShield.json
```
