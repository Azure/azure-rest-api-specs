## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-authorization"
  output-folder: "$(typescript-sdks-folder)/packages/@azure/arm-authorization"
  payload-flattening-threshold: 1
  generate-metadata: true
```
