## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-arm-edgegateway
  output-folder: $(node-sdks-folder)/lib/services/edgegatewayManagement
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: false
```
