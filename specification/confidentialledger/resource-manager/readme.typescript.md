## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
title: ConfidentialLedgerClient
typescript:
  azure-arm: true
  package-name: "@azure/arm-confidentialledger"
  output-folder: "$(typescript-sdks-folder)/sdk/confidentialledger/arm-confidentialledger"
  payload-flattening-threshold: 1
  generate-metadata: true
```
