## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-blockchain"
  output-folder: "$(typescript-sdks-folder)/packages/@azure/arm-blockchain"
  clear-output-folder: true
  generate-metadata: true
```
