## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-batch
  output-folder: $(node-sdks-folder)/lib/services/batch
  payload-flattening-threshold: 1
  generate-license-txt: true
  generate-package-json: false
  generate-readme-md: false
```