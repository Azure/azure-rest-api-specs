## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-machinelearningexperimentation"
  output-folder: "$(typescript-sdks-folder)/packages/@azure/arm-machinelearningexperimentation"
  generate-metadata: true
```
