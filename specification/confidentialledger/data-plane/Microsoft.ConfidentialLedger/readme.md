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

These are the global settings for Confidential Ledger.

``` yaml
tag: package-preview-2024-12-09
openapi-type: data-plane
```

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
```

### Tag: package-2024-08-22-preview-ledger

These settings apply only when `--tag=package-2024-08-22-preview-ledger` is specified on the command line.

```yaml $(tag) == 'package-2024-08-22-preview-ledger'
input-file:
  - Microsoft.ConfidentialLedger/preview/2024-08-22-preview/confidentialledger.json
```

### Tag: package-2024-08-22-preview-identity

These settings apply only when `--tag=package-2024-08-22-preview-identity` is specified on the command line.

```yaml $(tag) == 'package-2024-08-22-preview-identity'
input-file:
  - Microsoft.ConfidentialLedger/preview/2024-08-22-preview/identityservice.json
```

### Tag: package-2024-12-09-preview-ledger

These settings apply only when `--tag=package-2024-12-09-preview-ledger` is specified on the command line.

```yaml $(tag) == 'package-2024-12-09-preview-ledger'
input-file:
  - Microsoft.ConfidentialLedger/preview/2024-12-09-preview/confidentialledger.json
directive:
  - suppress: HostParametersValidation
    reason: Existing API, change would potentially be breaking.
```

### Tag: package-2024-12-09-preview-identity

These settings apply only when `--tag=package-2024-12-09-preview-identity` is specified on the command line.

```yaml $(tag) == 'package-2024-12-09-preview-identity'
input-file:
  - Microsoft.ConfidentialLedger/preview/2024-12-09-preview/identityservice.json
directive:
  - suppress: HostParametersValidation
    reason: Existing API, change would potentially be breaking.
```
