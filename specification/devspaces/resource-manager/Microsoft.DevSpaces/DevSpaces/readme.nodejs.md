## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-devspaces
  output-folder: $(node-sdks-folder)/lib/services/devspacesManagement
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
input-file:
- Microsoft.DevSpaces/stable/2019-04-01/devspaces.json
```
