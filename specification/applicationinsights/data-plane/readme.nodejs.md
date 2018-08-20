
## NodeJS
These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to the root directory of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  package-name: azure-applicationinsights-query
  package-version: 1.0.0-Preview-1
  output-folder: $(node-sdks-folder)/lib/services/applicationinsights-query
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
directive:
  - reason: Remove Events_GetOdataMetadata from Node SDK due to XML issues. 
    remove-operation: Events_GetOdataMetadata
```