# Azure Purview Data Quality

> This service has been migrated to TypeSpec. For the latest specification, see the TypeSpec project at `../Azure.Analaytics.Purview.DataQuality/`.

> see https://aka.ms/autorest

This is the legacy AutoRest configuration file for Purview Data Quality.

**Note: This service has been migrated to TypeSpec. For active development and the latest API  
specification, please refer to the TypeSpec project located at 
`../Azure.Analaytics.Purview.DataQuality/`.**

## TypeSpec Project

The current TypeSpec specification is located at:

- **Main TypeSpec files**: `../Azure.Analaytics.Purview.DataQuality/`
- **Configuration**: `../Azure.Analaytics.Purview.DataQuality/tspconfig.yaml`
- **Models**: `../Azure.Analaytics.Purview.DataQuality/models.tsp`
- **Routes**: `../Azure.Analaytics.Purview.DataQuality/routes.tsp`

To compile the TypeSpec specification:

```bash
cd ../Azure.Analaytics.Purview.DataQuality
npx tsp compile .
```

---

## Legacy AutoRest Configuration (Deprecated)

The following configuration is maintained for backward compatibility but is deprecated.

---

## Getting Started

To build the SDK for Purview, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`
To see additional help and options, run:
> `autorest --help`
---

## Configuration

### Basic Information

These are the global settings for the Azure Purview Catalog API.

```yaml
openapi-type: data-plane
tag: package-2026-01-12-preview
```

### Tag: package-2025-09-01-preview

These settings apply only when `--tag=package-2025-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-09-01-preview'
input-file:
  - Azure.Analaytics.Purview.DataQuality/preview/2025-09-01-preview/purviewDataQuality.json
```

### Tag: package-2026-01-12-preview

These settings apply only when `--tag=package-2026-01-12-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-01-12-preview'
input-file:
  - Azure.Analaytics.Purview.DataQuality/preview/2026-01-12-preview/purviewDataQuality.json
```

### LintDiff suppressions for package-2026-01-12-preview (TypeSpec-generated)

OpenAPI for 2026-01-12-preview is emitted from TypeSpec. Per [Swagger LintDiff for TypeSpec](https://github.com/Azure/azure-rest-api-specs/wiki/Swagger-LintDiff#typespec), data-plane specs may suppress these rules when the spec is generated from TypeSpec and SDKs are generated from TypeSpec.

```yaml $(tag) == 'package-2026-01-12-preview'
directive:
  - suppress: AvoidNestedProperties
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; SDKs are generated from TypeSpec.
  - suppress: EnumInsteadOfBoolean
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; SDKs are generated from TypeSpec.
  - suppress: GetInOperationName
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; existing service operation names.
  - suppress: ListInOperationName
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; existing service operation names.
  - suppress: LongRunningOperationsOptionsValidator
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; LRO behavior is service-defined.
  - suppress: LroExtension
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; 202 accepted for async clone/jobs without full LRO extension.
  - suppress: LroHeaders
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; LRO behavior is service-defined.
  - suppress: OperationId
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; existing service operation names.
  - suppress: PageableOperation
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; pagination is service-defined.
  - suppress: PaginationResponse
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; pagination is service-defined.
  - suppress: ParameterNamesConvention
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; parameter names are existing.
  - suppress: PatchContentType
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec.
  - suppress: PathParameterNames
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; path parameter names are existing.
  - suppress: PathParameterSchema
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec.
  - suppress: Post201Response
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; response codes are service-defined.
  - suppress: PropertyType
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec.
  - suppress: PutPath
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; paths are existing.
  - suppress: RequestBodyOptional
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; optional body is intentional (e.g. clone).
  - suppress: SecurityDefinitionDescription
    from: purviewDataQuality.json
    reason: Data-plane spec is generated from TypeSpec; security is defined in TypeSpec.
```

---

# Code Generation

## C-Sharp

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Azure.Analaytics.Purview.DataQuality
  add-credentials: true
  output-folder: $(csharp-sdks-folder)/purview/Azure.Analaytics.Purview.DataQuality/src/Generated
  clear-output-folder: true
```
