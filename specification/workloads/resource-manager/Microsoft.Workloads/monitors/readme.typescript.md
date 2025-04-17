## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-workloads-sapmonitors"
  output-folder: "$(typescript-sdks-folder)/sdk/workloads/sapmonitors"
  payload-flattening-threshold: 1
  clear-output-folder: true
  generate-metadata: true
directive:
  - where-operation: monitors_Create
    transform: delete $["x-ms-long-running-operation-options"]
  - where-operation: ProviderInstances_Create
    transform: delete $["x-ms-long-running-operation-options"]
```