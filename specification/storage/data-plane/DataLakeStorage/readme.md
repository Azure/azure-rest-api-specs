# StorageDataLake

> see https://aka.ms/autorest

This is the AutoRest configuration file for StorageDataLake.

---

## Getting Started

To build the SDK for StorageDataLake, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information

These are the global settings for the StorageDataLake API.

``` yaml
openapi-type: data-plane
tag: package-2026-06-tsp
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2018-06-preview

These settings apply only when `--tag=package-2018-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-preview'
input-file:
- preview/2018-06-17/DataLakeStorage.json
```

### Tag: package-2020-06

These settings apply only when `--tag=package-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-2020-06'
input-file:
- preview/2020-06-12/DataLakeStorage.json
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10'
input-file:
- preview/2020-10-02/DataLakeStorage.json
```

### Tag: package-2021-04

These settings apply only when `--tag=package-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-2021-04'
input-file:
- preview/2021-04-10/DataLakeStorage.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
- preview/2021-06-08/DataLakeStorage.json
```

### Tag: package-2023-05-preview

These settings apply only when `--tag=package-2023-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-05-preview'
input-file:
- preview/2023-05-03/DataLakeStorage.json
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-2023-05'
input-file:
- stable/2023-05-03/DataLakeStorage.json
```

### Tag: package-2025-01

These settings apply only when `--tag=package-2025-01` is specified on the command line.

``` yaml $(tag) == 'package-2025-01'
input-file:
- stable/2025-01-05/DataLakeStorage.json
```

### Tag: package-2025-05

These settings apply only when `--tag=package-2025-05` is specified on the command line.

``` yaml $(tag) == 'package-2025-05'
input-file:
- stable/2025-05-05/DataLakeStorage.json
```

### Tag: package-2026-02

These settings apply only when `--tag=package-2026-02` is specified on the command line.

``` yaml $(tag) == 'package-2026-02'
input-file:
- stable/2026-02-06/DataLakeStorage.json
```

### Tag: package-2026-06

These settings apply only when `--tag=package-2026-06` is specified on the command line.

``` yaml $(tag) == 'package-2026-06'
input-file:
- stable/2026-06-06/DataLakeStorage.json
```

### Tag: package-2026-06-tsp

These settings apply only when `--tag=package-2026-06-tsp` is specified on the command line.

```yaml $(tag) == 'package-2026-06-tsp'
input-file:
  - stable/2026-06-06/generated_datalake.json
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
    from: generated_datalake.json
    reason: Legacy operations not defined as lro
```

```yaml
directive:
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    from: generated_datalake.json
    reason: Service uses XML, not JSON, so cannot validate.
  - suppress: ValidFormats
    from: generated_datalake.json
    reason: Properly specifying parameter format.
  - suppress: EnumInsteadOfBoolean
    from: generated_datalake.json
    reason: Existing API contract
  - suppress: ErrorResponse
    from: generated_datalake.json
    reason: Existing API contract
  - suppress: MsPaths
    from: generated_datalake.json
    reason: Auto-generated swagger based on typespec
  - suppress: SuccessResponseBody
    from: generated_datalake.json
    reason: Existing API contract
  - suppress: LroHeaders
    from: generated_datalake.json
    reason: Existing API contract
  - suppress: VersionPolicy
    from: generated_datalake.json
    reason: Existing API with api version header
  - suppress: PutInOperationName
    from: generated_datalake.json
    reason: Existing API with sdk usage
  - suppress: OperationId
    from: generated_datalake.json
  - suppress: GetInOperationName
    from: generated_datalake.json
  - suppress: XmsEnumValidation
    from: generated_datalake.json
    reason: Existing API contract and auto-generated enum definitions
  - suppress: SecurityDefinitionDescription
    from: generated_datalake.json
    reason: Auto-generated swagger from typespec
  - suppress: PathParameterSchema
    from: generated_datalake.json
    reason: Existing API contract
  - suppress: PutRequestResponseScheme
    from: generated_datalake.json
    reason: Existing API contract
```

---
