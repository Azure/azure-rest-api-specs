## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: "@azure/arm-agrifood"
  output-folder: "$(typescript-sdks-folder)/sdk/agrifood/arm-agrifood"
  payload-flattening-threshold: 1
  generate-metadata: true
```
