# confidentialledger

Confidential Ledger provides SDKs for the following languages:

- [Python](https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/confidentialledger/azure-confidentialledger/azure/confidentialledger)
- [Javascript/Typescript](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/confidentialledger/confidential-ledger-rest/swagger/README.md)
- [Java](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/confidentialledger/azure-security-confidentialledger/swagger/README.md)
- [C#](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/confidentialledger/Azure.Security.ConfidentialLedger/src/autorest.md)

**Please look to the typespec files under `specification/confidentialledger/data-plane/ConfidentialLedger` for the most up-to-date API changes.**

> see https://aka.ms/autorest

## Configuration

### Basic Information

These are the global settings for Confidential Ledger.

```yaml
tag: package-2022-05-13-ledger
openapi-type: data-plane
```

### Tag: package-2022-05-13-ledger

These settings apply only when `--tag=package-2022-05-13-ledger` is specified on the command line.

```yaml $(tag) == 'package-2022-05-13-ledger'
input-file:
  - stable/2022-05-13/confidentialledger.json
```

### Tag: package-2022-05-13-identity

These settings apply only when `--tag=package-2022-05-13-identity` is specified on the command line.

```yaml $(tag) == 'package-2022-05-13-identity'
input-file:
  - stable/2022-05-13/identityservice.json
```
