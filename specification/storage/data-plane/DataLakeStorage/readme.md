# DataLakeStorage

> see https://aka.ms/autorest

This is the configuration file for DataLakeStorage swaggers.

---

## Getting Started

To generate the swagger in this folder, run:

> `tsp compile .`

To see additional help and options, run:

> `tsp --help`

---

## Configuration

### Basic Information

These are the global settings for the FileStorage API.

```yaml
openapi-type: data-plane
tag: package-2026-02-tsp
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2026-04-tsp

These settings apply only when `--tag=package-2026-02-tsp` is specified on the command line.

```yaml $(tag) == 'package-2026-02-tsp'
input-file:
  - stable/2026-02-06/DataLakeStorage.json
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

```yaml
suppressions:
  - code: LroExtension
    from: DataLakeStorage.json
    reason: Legacy operations not defined as lro
```

```yaml
directive:
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    from: DataLakeStorage.json
    reason: Service uses XML, not JSON, so cannot validate.
  - suppress: ValidFormats
    from: DataLakeStorage.json
    reason: Properly specifying parameter format.
  - suppress: EnumInsteadOfBoolean
    from: DataLakeStorage.json
    reason: Existing API contract
  - suppress: ErrorResponse
    from: DataLakeStorage.json
    reason: Existing API contract
  - suppress: MsPaths
    from: DataLakeStorage.json
    reason: Auto-generated swagger based on typespec
  - suppress: SuccessResponseBody
    from: DataLakeStorage.json
    reason: Existing API contract
  - suppress: LroHeaders
    from: DataLakeStorage.json
    reason: Existing API contract
  - suppress: VersionPolicy
    from: DataLakeStorage.json
    reason: Existing API with api version header
  - suppress: PutInOperationName
    from: DataLakeStorage.json
    reason: Existing API with sdk usage
  - suppress: OperationId
    from: DataLakeStorage.json
  - suppress: GetInOperationName
    from: DataLakeStorage.json
  - suppress: XmsEnumValidation
    from: DataLakeStorage.json
    reason: Existing API contract and auto-generated enum definitions
  - suppress: SecurityDefinitionDescription
    from: DataLakeStorage.json
    reason: Auto-generated swagger from typespec
  - suppress: PathParameterSchema
    from: DataLakeStorage.json
    reason: Existing API contract
  - suppress: PutRequestResponseScheme
    from: DataLakeStorage.json
    reason: Existing API contract
```

---
