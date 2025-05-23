## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/consumption/armconsumption
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
  - from: consumption_pricesheet.json
    where: $.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingPeriods/{billingPeriodName}/providers/Microsoft.Consumption/pricesheets/download"].post.responses.default.schema
    transform: >
      $["$ref"] = "consumption.json#/definitions/ErrorResponse";
```
