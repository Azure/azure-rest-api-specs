# confidentialledger

Confidential Ledger provides SDKs for the following languages:

- [Python](https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/confidentialledger/azure-confidentialledger/azure/confidentialledger)
- [Javascript/Typescript](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/confidentialledger/confidential-ledger-rest/swagger/README.md)
- [Java](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/confidentialledger/azure-security-confidentialledger/swagger/README.md)
- [C#](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/confidentialledger/Azure.Security.ConfidentialLedger/src/autorest.md)

Please look to the files `Microsoft.ConfidentialLedger/preview/2023-01-18-preview/confidentialledger.json` and `Microsoft.ConfidentialLedger/preview/2023-01-18-preview/identityservice.json` for the most up-to-date API changes.

> see https://aka.ms/autorest

``` yaml
tag: package-2024-01-26-preview-identity
openapi-type: data-plane
```

## Configuration

### Tag: package-0.1-preview-ledger

These settings apply only when `--tag=package-0.1-preview-ledger` is specified on the command line.

```yaml $(tag) == 'package-0.1-preview-ledger'
input-file:
  - Microsoft.ConfidentialLedger/preview/0.1-preview/confidentialledger.json
```

### Tag: package-0.1-preview-identity

These settings apply only when `--tag=package-0.1-preview-identity` is specified on the command line.

```yaml $(tag) == 'package-0.1-preview-identity'
input-file:
  - Microsoft.ConfidentialLedger/preview/0.1-preview/identityservice.json
```

### Tag: package-2022-20-04-preview-ledger

These settings apply only when `--tag=package-2022-20-04-preview-ledger` is specified on the command line.

```yaml $(tag) == 'package-2022-04-20-preview-ledger'
input-file:
  - Microsoft.ConfidentialLedger/preview/2022-04-20-preview/confidentialledger.json
```

### Tag: package-2022-20-04-preview-identity

These settings apply only when `--tag=package-2022-20-04-preview-identity` is specified on the command line.

```yaml $(tag) == 'package-2022-04-20-preview-identity'
input-file:
  - Microsoft.ConfidentialLedger/preview/2022-04-20-preview/identityservice.json
```

### Tag: package-2022-05-13-ledger

These settings apply only when `--tag=package-2022-05-13-ledger` is specified on the command line.

```yaml $(tag) == 'package-2022-05-13-ledger'
input-file:
  - Microsoft.ConfidentialLedger/stable/2022-05-13/confidentialledger.json
```

### Tag: package-2022-05-13-identity

These settings apply only when `--tag=package-2022-05-13-identity` is specified on the command line.

```yaml $(tag) == 'package-2022-05-13-identity'
input-file:
  - Microsoft.ConfidentialLedger/stable/2022-05-13/identityservice.json
```

### Tag: package-2023-01-18-preview-ledger

These settings apply only when `--tag=package-2023-01-18-preview-ledger` is specified on the command line.

```yaml $(tag) == 'package-2023-01-18-preview-ledger'
input-file:
  - Microsoft.ConfidentialLedger/preview/2023-01-18-preview/confidentialledger.json
```

### Tag: package-2023-01-18-preview-identity

These settings apply only when `--tag=package-2023-01-18-preview-identity` is specified on the command line.

```yaml $(tag) == 'package-2023-01-18-preview-identity'
input-file:
  - Microsoft.ConfidentialLedger/preview/2023-01-18-preview/identityservice.json
```

### Tag: package-2023-06-01-preview-mccf

These settings apply only when `--tag=package-2023-06-01-preview-mccf` is specified on the command line.

```yaml $(tag) == 'package-2023-06-01-preview-mccf'
input-file:
  - Microsoft.ManagedCcf/preview/2023-06-01-preview/mccfgov.json
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

### Tag: package-2024-01-26-preview-ledger

These settings apply only when `--tag=package-2024-01-26-preview-ledger` is specified on the command line.

```yaml $(tag) == 'package-2024-01-26-preview-ledger'
input-file:
  - Microsoft.ConfidentialLedger/preview/2024-01-26-preview/confidentialledger.json
```

### Tag: package-2024-01-26-preview-identity

These settings apply only when `--tag=package-2024-01-26-preview-identity` is specified on the command line.

```yaml $(tag) == 'package-2024-01-26-preview-identity'
input-file:
  - Microsoft.ConfidentialLedger/preview/2024-01-26-preview/identityservice.json