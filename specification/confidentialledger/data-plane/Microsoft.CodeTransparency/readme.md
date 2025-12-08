# confidentialledger

Confidential Ledger provides SDKs for the following languages:

- [Python](https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/confidentialledger/azure-confidentialledger/azure/confidentialledger)
- [Javascript/Typescript](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/confidentialledger/confidential-ledger-rest/swagger/README.md)
- [Java](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/confidentialledger/azure-security-confidentialledger/swagger/README.md)
- [C#](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/confidentialledger/Azure.Security.ConfidentialLedger/src/autorest.md)

Please look to the files `Microsoft.ConfidentialLedger/preview/2024-12-09-preview/confidentialledger.json` and `Microsoft.ConfidentialLedger/preview/2024-12-09-preview/identityservice.json` for the most up-to-date API changes.

> see https://aka.ms/autorest

## Configuration

### Basic Information

These are the global settings for Microsoft Code Transparency.

```yaml
tag: package-2025-01-31-preview-codetransparency
openapi-type: data-plane
```

### Tag: package-2024-01-11-preview-codetransparency

These settings apply only when `--tag=package-2024-01-11-preview-codetransparency` is specified on the command line.

```yaml $(tag) == 'package-2024-01-11-preview-codetransparency'
input-file:
  - preview/2024-01-11-preview/cts.json
suppressions:
  - code: PageableOperation
    from: cts.json
    reason: Not pageable
  - code: PaginationResponse
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
  - preview/2025-01-31-preview/cts.json
suppressions:
  - code: LroExtension
    from: cts.json
    reason: Following RFC which does not specify this
  - code: ErrorResponse
    from: cts.json
    reason: No way to express when using CBOR
```
