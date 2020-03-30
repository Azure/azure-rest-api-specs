## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-commerce"
  output-folder: "$(typescript-sdks-folder)/sdk/commerce/arm-commerce"
  clear-output-folder: true
  payload-flattening-threshold: 2
  generate-metadata: true
```
