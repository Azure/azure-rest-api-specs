## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/applicationinsights/armapplicationinsights/v2
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
modelerfour:
  lenient-model-deduplication: true
directive:
# Duplicate OperationId Operations_List is detected in Microsoft.Insights/stable/2015-05-01/aiOperations_API.json and Microsoft.Insights/preview/2020-06-02-preview/livetoken_API.json
  from: aiOperations_API.json
  where: $.paths
  transform: delete $["/providers/Microsoft.Insights/operations"]
```
