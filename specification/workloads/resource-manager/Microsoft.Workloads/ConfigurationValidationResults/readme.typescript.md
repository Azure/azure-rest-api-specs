## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-workloads-configurationvalidationresults"
  output-folder: "$(typescript-sdks-folder)/sdk/workloads/arm-configurationvalidationresults"
  payload-flattening-threshold: 1
  clear-output-folder: true
  generate-metadata: true
```