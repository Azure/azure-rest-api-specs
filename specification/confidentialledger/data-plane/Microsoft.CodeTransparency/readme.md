# Code Transparency

Code Transparency provides data plane SDKs for the following languages:

- [C#](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/confidentialledger/Azure.Security.CodeTransparency)

> see https://aka.ms/autorest

## Configuration

### Basic Information

These are the global settings for Confidential Ledger.

``` yaml
tag: package-2025-01-31-preview-codetransparency
openapi-type: data-plane
```

### Tag: package-2024-01-11-preview-codetransparency

These settings apply only when `--tag=package-2024-01-11-preview-codetransparency` is specified on the command line.

```yaml $(tag) == 'package-2024-01-11-preview-codetransparency'
input-file:
  - Microsoft.CodeTransparency/preview/2024-01-11-preview/cts.json
suppressions:
  - code: PageableOperation
    from: cts.json
    reason: Not pageable
  - code:  PaginationResponse
    from: cts.json
    reason: Defined as in the RFC but the remaining ones are not pageable
  - code: PathParameterSchema
    from: cts.json
    reason: maxLength parameter is not applicable
  - code: DefaultResponse
    from: cts.json
    reason: TypeSpec did not generate this
  - code: EnumInsteadOfBoolean
    from: cts.json
    reason: Defined as in the RFC
```

### Tag: package-2025-01-31-preview-codetransparency

These settings apply only when `--tag=package-2025-01-31-preview-codetransparency` is specified on the command line.

```yaml $(tag) == 'package-2025-01-31-preview-codetransparency'
input-file:
  - Microsoft.CodeTransparency/preview/2025-01-31-preview/cts.json
suppressions:
  - code: LroExtension
    from: cts.json
    reason: Following RFC which does not specify this
  - code: ErrorResponse
    from: cts.json
    reason: No way to express when using CBOR
```
