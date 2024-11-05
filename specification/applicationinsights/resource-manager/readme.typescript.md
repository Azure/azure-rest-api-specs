## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-appinsights"
  output-folder: "$(typescript-sdks-folder)/sdk/applicationinsights/arm-appinsights"
  generate-metadata: true

directive:
  # Duplicate OperationId Operations_List is detected in Microsoft.Insights/stable/2015-05-01/aiOperations_API.json and Microsoft.Insights/preview/2020-06-02-preview/livetoken_API.json
    from: aiOperations_API.json
    where: $.paths
    transform: delete $["/providers/Microsoft.Insights/operations"]
```


