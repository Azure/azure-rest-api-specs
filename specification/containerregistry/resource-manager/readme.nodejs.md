## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-containerregistry
  package-version: 2.3.0
  output-folder: $(node-sdks-folder)/lib/services/containerRegistryManagement
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
input-file:
- Microsoft.ContainerRegistry/stable/2017-10-01/containerregistry.json
- Microsoft.ContainerRegistry/preview/2018-02-01-preview/containerregistry_build.json
```
