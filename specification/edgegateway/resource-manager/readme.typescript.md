## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: "@azure/arm-edgedateway"
  output-folder: "$(typescript-sdks-folder)/packages/@azure/arm-edgedateway"
  generate-metadata: true
```
