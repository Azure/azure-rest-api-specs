## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/monitor/armmonitor
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true

directive:
  - from: scheduledQueryRule_API.json # this is to resolve the duplicated schema issue in this swagger
    where: "$.definitions.Resource"
    transform: >
      $["x-ms-client-name"] = "TrackedEntityResource";
  - rename-operation:
      from: 'MonitorOperations_List'
      to: 'OperationsForMonitor_List'
modelerfour:
  lenient-model-deduplication: true
```
