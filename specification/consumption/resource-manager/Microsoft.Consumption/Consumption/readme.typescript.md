## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-consumption"
  output-folder: "$(typescript-sdks-folder)/sdk/consumption/arm-consumption"
  generate-metadata: true

directive:
  - from: consumption_pricesheet.json
    where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingPeriods/{billingPeriodName}/providers/Microsoft.Consumption/pricesheets/download"].post.responses.default.schema
    transform: >
      $["$ref"] = "consumption.json#/definitions/ErrorResponse";
```
