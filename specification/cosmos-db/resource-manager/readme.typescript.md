## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-cosmosdb"
  output-folder: "$(typescript-sdks-folder)/sdk/cosmosdb/arm-cosmosdb"
  override-client-name: CosmosDBManagementClient
  generate-metadata: true

directive: 
- from: swagger-document
  where: $.paths..responses.default
  transform: >
    $.schema = {
      "$ref": "../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse"
    }

- from: cosmos-db.json
  where: $.definitions
  transform: delete $.CloudError

- from: cosmos-db.json
  where: $.definitions
  transform: delete $.ErrorResponse

- from: dataTransferService.json
  where: $.definitions.DataTransferJobProperties.properties.error
  transform: >
    $.$ref = "../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse"
```
