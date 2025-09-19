## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-datalake-store
  output-folder: $(node-sdks-folder)/lib/services/datalake.Store
  source-code-folder-path: lib/filesystem
  generate-license-txt: false
  generate-package-json: false
  generate-readme-md: false
```
