## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-apimanagement"
  output-folder: "$(typescript-sdks-folder)/sdk/apimanagement/arm-apimanagement"
  generate-metadata: true

directive:
- from: definitions.json
  where: $.definitions.ApiVersionSetContractDetails
  transform: >
    $.properties.versioningScheme["x-ms-enum"].name = "ApiVersionSetContractDetailsVersioningScheme"
```
