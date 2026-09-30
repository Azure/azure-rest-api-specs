## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/costmanagement/armcostmanagement/v2
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
modelerfour:
  lenient-model-deduplication: true
directive:
- rename-model:
    from: 'CostManagementOperation'
    to: 'OperationForCostManagement'
- rename-model:
    from: 'CostManagementProxyResource'
    to: 'ProxyResourceForCostManagement'
- from: costmanagement.json
  where: 
    - $.definitions.View.allOf[0]
    - $.definitions.Alert.allOf[0]
  transform: > 
    $['$ref'] = "common-types.json#/definitions/ProxyResourceForCostManagement";
- from: costmanagement.exports.json
  where: 
    - $.definitions.Export.allOf[0]
    - $.definitions.ExportRun.allOf[0]
  transform: > 
    $['$ref'] = "common-types.json#/definitions/ProxyResourceForCostManagement";
- from: costmanagement.budgets.json
  where: 
    - $.definitions.Budget.allOf[0]
  transform: > 
    $['$ref'] = "common-types.json#/definitions/ProxyResourceForCostManagement";
- rename-model:
    from: 'CostManagementResource'
    to: 'ResourceForCostManagement'
```
