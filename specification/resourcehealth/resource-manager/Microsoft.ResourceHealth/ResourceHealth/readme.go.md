## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resourcehealth/armresourcehealth
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
v3: true
directive:
  - from: ResourceHealth.json
    where: $.definitions.availabilityStatus.properties.properties.properties.occuredTime
    transform:
      $["x-ms-client-name"] = "occurredTime"
  - from: ResourceHealth.json
    where: $.definitions.availabilityStatus.properties.properties.properties.recentlyResolved.properties.unavailableOccuredTime
    transform:
      $["x-ms-client-name"] = "unavailableOccurredTime"
  - from: ResourceHealth.json
    where: $.definitions.availabilityStatus.properties.properties.properties.recentlyResolved.properties.unavailableSummary
    transform:
      $["x-ms-client-name"] = "unavailabilitySummary"
```
