## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-trustedsigning"
  output-folder: "$(typescript-sdks-folder)/sdk/trustedsigning/arm-trustedsigning"
  payload-flattening-threshold: 1
  clear-output-folder: true
  generate-metadata: true
```