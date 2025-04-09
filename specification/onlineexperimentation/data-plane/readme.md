# Online Experimentation

> see https://aka.ms/autorest

This is the AutoRest configuration file for Online Experimentation

## Getting Started

To build the SDKs for Online Experimentation, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Online Experimentation.

```yaml
title: Online Experimentation Data Plane
openapi-type: data-plane
tag: package-2025-05-31-preview
```

### Tag: package-2025-05-31-preview

These settings apply only when `--tag=package-2025-05-31-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-05-31-preview'
input-file:
  - Microsoft.OnlineExperimentation/preview/2025-05-31-preview/onlineexperimentation.json
```

### Suppress non-TypeSpec SDK related linting rules

These set of linting rules aren't applicable to the new TypeSpec SDK code generators so suppressing them here. Eventually we will
opt-out these rules from running in the linting tools for TypeSpec generated swagger files.

```yaml
suppressions:
  - code: AvoidAnonymousTypes
  - code: PatchInOperationName
  - code: OperationIdNounVerb
  - code: RequiredReadOnlyProperties
  - code: SchemaNamesConvention
  - code: SchemaDescriptionOrTitle
```

### Suppress rules that might be fixed

These set of linting rules we expect to fixed in typespec-autorest emitter but for now suppressing.
Github issue filed at <https://github.com/Azure/typespec-azure/issues/2762>

```yaml
suppressions:
  - code: LroExtension
  - code: SchemaTypeAndFormat
  - code: PathParameterSchema
```
