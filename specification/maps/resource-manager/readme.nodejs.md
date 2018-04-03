## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-maps
  package-version: 1.0.0-preview
<<<<<<< HEAD:specification/maps/resource-manager/readme.nodejs.md
  output-folder: $(node-sdks-folder)/lib/services/maps/Management
=======
  output-folder: $(node-sdks-folder)/lib/services/mapsManagement
>>>>>>> af5df6db5ec3595baf856483bdd207673c3667df:specification/maps/resource-manager/readme.nodejs.md
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
```
