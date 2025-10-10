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

These are the global settings for Managed CCF.

```yaml
tag: package-2023-06-01-preview-mccf
openapi-type: data-plane
```

### Tag: package-2023-06-01-preview-mccf

These settings apply only when `--tag=package-2023-06-01-preview-mccf` is specified on the command line.

```yaml $(tag) == 'package-2023-06-01-preview-mccf'
input-file:
  - preview/2023-06-01-preview/mccfgov.json
```
