# Split.IO

> see https://aka.ms/autorest

This is the AutoRest configuration file for Split.IO.

## Getting Started

To build the SDK for Split.IO, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Split.IO.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-07-01-preview
```

### Tag: package-2024-07-01-preview

These settings apply only when `--tag=package-2024-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-07-01-preview'
input-file:
  - SplitIO.Experimentation/preview/2024-07-01-preview/splitio.json
```

### Tag: package-2024-03-01-preview

These settings apply only when `--tag=package-2024-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01-preview'
input-file:
  - SplitIO.Experimentation/preview/2024-03-01-preview/splitio.json
```
# Code Generation

## Suppression
``` yaml
directive:
  - suppress: PathResourceProviderNamePascalCase
    from: splitio.json
    reason: This is a specific resource provider name requested by liftr partner.
  - suppress: PatchBodyParametersSchema
    from: splitio.json
    reason: Typespec generated update parameters include common types which contain required properties.
  - suppress: AvoidAnonymousTypes
    from: splitio.json
    reason: Typespec generated definitions contain anonymous types.
