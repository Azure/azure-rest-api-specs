## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
title: LargeInstanceManagementClient
typescript:
  azure-arm: true
  package-name: "@azure/arm-largeinstance"
  output-folder: "$(typescript-sdks-folder)/sdk/largeinstance/arm-largeinstance"
  payload-flattening-threshold: 1
  clear-output-folder: true
  generate-metadata: true

directive:
  - from: azurelargeinstance.json 
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureLargeInstance/azureLargeInstances/{azureLargeInstanceName}"].patch.parameters'
    transform: >
      for (const param of $) {
        if (param['name'] == 'tagsParameter') {
           delete param["x-ms-client-name"]
        }
      }
  - from: azurelargeinstance.json 
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureLargeInstance/azureLargeStorageInstances/{azureLargeStorageInstanceName}"].patch.parameters'
    transform: >
      for (const param of $) {
        if (param['name'] == 'tagsParameter') {
           delete param["x-ms-client-name"]
        }
      }

```
