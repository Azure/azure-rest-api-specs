## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-securityinsight"
  output-folder: "$(typescript-sdks-folder)/sdk/securityinsight/arm-securityinsight"
  generate-metadata: true

directive: 
  - from: DataConnectors.json
    where: $.definitions.CcpResponseConfig.properties.csvEscape
    transform: >
      $["default"] = "\\\""
  - from: dataConnectors.json
    where: $.definitions.CcpResponseConfig.properties.csvEscape
    transform: >
      $["default"] = "\\\""
```
