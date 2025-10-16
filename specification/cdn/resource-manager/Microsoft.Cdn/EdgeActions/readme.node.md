# Node.js EdgeActions

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--nodejs-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

```yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-edgeactions
  output-folder: $(nodejs-sdks-folder)/lib/services/edgeactionsManagement
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
```
