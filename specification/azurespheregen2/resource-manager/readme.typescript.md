## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-azurespheregen2"
  output-folder: "$(typescript-sdks-folder)/sdk/azurespheregen2/arm-azurespheregen2"
  clear-output-folder: true
  generate-metadata: true
```