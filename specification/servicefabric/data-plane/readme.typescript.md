## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: false
  package-name: "@azure/servicefabric"
  output-folder: "$(typescript-sdks-folder)/sdk/servicefabric/servicefabric"
  override-client-name: ServiceFabricClient
  generate-metadata: true
```
