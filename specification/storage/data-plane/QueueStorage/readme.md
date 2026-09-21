# QueueStorage

> see https://aka.ms/autorest

This is the AutoRest configuration file for QueueStorage.

---

## Getting Started

To build the SDK for QueueStorage, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information

These are the global settings for the QueueStorage API.

``` yaml
openapi-type: data-plane
tag: package-2026-04-tsp
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2018-03-preview

These settings apply only when `--tag=package-2018-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-preview'
input-file:
- preview/2018-03-28/queue.json
```

### Tag: package-2018-03

These settings apply only when `--tag=package-2018-03` is specified on the command line.

``` yaml $(tag) == 'package-2018-03'
input-file:
- stable/2018-03-28/queue.json
```

### Tag: package-2026-02

These settings apply only when `--tag=package-2026-02` is specified on the command line.

``` yaml $(tag) == 'package-2026-02'
input-file:
- stable/2026-02-06/queue.json
```

### Tag: package-2026-04

These settings apply only when `--tag=package-2026-04` is specified on the command line.

``` yaml $(tag) == 'package-2026-04'
input-file:
- stable/2026-04-06/queue.json
```

### Tag: package-2026-04-tsp

These settings apply only when `--tag=package-2026-04-tsp` is specified on the command line.

``` yaml $(tag) == 'package-2026-04-tsp'
input-file:
- stable/2026-04-06/generated_queue.json
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
    from: generated_queue.json
    reason: Legacy operations not defined as lro
```

```yaml
directive:
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    from: generated_queue.json
    reason: Service uses XML, not JSON, so cannot validate.
  - suppress: ValidFormats
    from: generated_queue.json
    reason: Properly specifying parameter format.
  - suppress: EnumInsteadOfBoolean
    from: generated_queue.json
    reason: Existing API contract
  - suppress: ErrorResponse
    from: generated_queue.json
    reason: Existing API contract
  - suppress: MsPaths
    from: generated_queue.json
    reason: Auto-generated swagger based on typespec
  - suppress: SuccessResponseBody
    from: generated_queue.json
    reason: Existing API contract
  - suppress: LroHeaders
    from: generated_queue.json
    reason: Existing API contract
  - suppress: VersionPolicy
    from: generated_queue.json
    reason: Existing API with api version header
  - suppress: PutInOperationName
    from: generated_queue.json
    reason: Existing API with sdk usage
  - suppress: OperationId
    from: generated_queue.json
  - suppress: GetInOperationName
    from: generated_queue.json
  - suppress: XmsEnumValidation
    from: generated_queue.json
    reason: Existing API contract and auto-generated enum definitions
  - suppress: SecurityDefinitionDescription
    from: generated_queue.json
    reason: Auto-generated swagger from typespec
  - suppress: PathParameterSchema
    from: generated_queue.json
    reason: Existing API contract
  - suppress: PutRequestResponseScheme
    from: generated_queue.json
    reason: Existing API contract
```

---
