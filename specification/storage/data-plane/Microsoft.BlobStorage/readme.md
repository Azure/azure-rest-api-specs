# BlobStorage

> see https://aka.ms/autorest

This is the AutoRest configuration file for BlobStorage.

---

## Getting Started

To build the SDK for BlobStorage, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the BlobStorage API.

```yaml
openapi-type: data-plane
tag: package-2026-04
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

```yaml $(tag) == 'package-2020-10'
input-file:
  - preview/2020-10-02/blob.json
```

### Tag: package-2020-12

These settings apply only when `--tag=package-2020-12` is specified on the command line.

```yaml $(tag) == 'package-2020-12'
input-file:
  - preview/2020-12-06/blob.json
```

### Tag: package-2021-02

These settings apply only when `--tag=package-2021-02` is specified on the command line.

```yaml $(tag) == 'package-2021-02'
input-file:
  - preview/2021-02-12/blob.json
```

### Tag: package-2021-04

These settings apply only when `--tag=package-2021-04` is specified on the command line.

```yaml $(tag) == 'package-2021-04'
input-file:
  - preview/2021-04-10/blob.json
```

### Tag: package-2021-08

These settings apply only when `--tag=package-2021-08` is specified on the command line.

```yaml $(tag) == 'package-2021-08'
input-file:
  - preview/2021-08-06/blob.json
```

### Tag: package-2021-12-preview

These settings apply only when `--tag=package-2021-12-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-12-preview'
input-file:
  - preview/2021-12-02/blob.json
```

### Tag: package-2021-12

These settings apply only when `--tag=package-2021-12` is specified on the command line.

```yaml $(tag) == 'package-2021-12'
input-file:
  - stable/2021-12-02/blob.json
```

### Tag: package-2024-08

These settings apply only when `--tag=package-2024-08` is specified on the command line.

```yaml $(tag) == 'package-2024-08'
input-file:
  - stable/2024-08-04/blob.json
```

### Tag: package-2025-01

These settings apply only when `--tag=package-2025-01` is specified on the command line.

```yaml $(tag) == 'package-2025-01'
input-file:
  - stable/2025-01-05/blob.json
```

### Tag: package-2025-07

These settings apply only when `--tag=package-2025-07` is specified on the command line.

```yaml $(tag) == 'package-2025-07'
input-file:
  - stable/2025-07-05/blob.json
```

### Tag: package-2025-11

These settings apply only when `--tag=package-2025-11` is specified on the command line.

```yaml $(tag) == 'package-2025-11'
input-file:
  - stable/2025-11-05/blob.json
```

### Tag: package-2025-11-tsp

These settings apply only when `--tag=package-2025-11-tsp` is specified on the command line.

```yaml $(tag) == 'package-2025-11-tsp'
input-file:
  - stable/2025-11-05/generated_blob.json
```

### Tag: package-2026-02-tsp

These settings apply only when `--tag=package-2026-02-tsp` is specified on the command line.

```yaml $(tag) == 'package-2026-02-tsp'
input-file:
  - stable/2026-02-06/generated_blob.json
```

### Tag: package-2026-02

These settings apply only when `--tag=package-2026-02` is specified on the command line.

```yaml $(tag) == 'package-2026-02'
input-file:
  - stable/2026-02-06/blob.json
```

### Tag: package-2026-04

These settings apply only when `--tag=package-2026-04` is specified on the command line.

```yaml $(tag) == 'package-2026-04'
input-file:
  - stable/2026-04-06/blob.json
```

### Tag: package-2026-04-tsp

These settings apply only when `--tag=package-2026-04-tsp` is specified on the command line.

```yaml $(tag) == 'package-2026-04-tsp'
input-file:
  - stable/2026-04-06/generated_blob.json
```

### Suppression

```yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: These parameters are predfined by storage specifications
  - suppress: XmsPathsMustOverloadPaths
  - suppress: XmsExamplesRequired
  - suppress: LongRunningOperationsWithLongRunningExtension
  - suppress: OAV107
```

---

```yaml
suppressions:
  - code: LroExtension
    from: generated_blob.json
    reason: Legacy operations not defined as lro
```

```yaml
directive:
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    from: generated_blob.json
    reason: Service uses XML, not JSON, so cannot validate.
  - suppress: ValidFormats
    from: generated_blob.json
    reason: Properly specifying parameter format.
  - suppress: EnumInsteadOfBoolean
    from: generated_blob.json
    reason: Existing API contract
  - suppress: ErrorResponse
    from: generated_blob.json
    reason: Existing API contract
  - suppress: MsPaths
    from: generated_blob.json
    reason: Auto-generated swagger based on typespec
  - suppress: SuccessResponseBody
    from: generated_blob.json
    reason: Existing API contract
  - suppress: LroHeaders
    from: generated_blob.json
    reason: Existing API contract
  - suppress: VersionPolicy
    from: generated_blob.json
    reason: Existing API with api version header
  - suppress: PutInOperationName
    from: generated_blob.json
    reason: Existing API with sdk usage
  - suppress: OperationId
    from: generated_blob.json
  - suppress: GetInOperationName
    from: generated_blob.json
  - suppress: XmsEnumValidation
    from: generated_blob.json
    reason: Existing API contract and auto-generated enum definitions
  - suppress: SecurityDefinitionDescription
    from: generated_blob.json
    reason: Auto-generated swagger from typespec
  - suppress: PathParameterSchema
    from: generated_blob.json
    reason: Existing API contract
  - suppress: PutRequestResponseScheme
    from: generated_blob.json
    reason: Existing API contract
```
