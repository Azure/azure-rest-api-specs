## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-cosmosdb"
  output-folder: "$(typescript-sdks-folder)/sdk/cosmosdb/arm-cosmosdb"
  clear-output-folder: true
  override-client-name: CosmosDBManagementClient
  generate-metadata: true
```
