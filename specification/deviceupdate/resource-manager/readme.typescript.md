## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-deviceupdate"
  output-folder: "$(typescript-sdks-folder)/sdk/deviceupdate/arm-deviceupdate"
  generate-metadata: true

directive:
- from: deviceupdate.json
  where: $.definitions.Account
  transform: >
    $.properties.properties.properties.sku["x-ms-enum"].name = "Sku"
```
