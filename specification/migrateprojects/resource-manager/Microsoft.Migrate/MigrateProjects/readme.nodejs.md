## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-migrateprojects
  package-version: 1.0.0-preview
  output-folder: $(node-sdks-folder)/lib/services/migrateprojectsManagement
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
```
