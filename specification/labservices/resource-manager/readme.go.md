## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/labservices/armlabservices
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
- rename-model:
    from: 'LabServicesSku'
    to: 'SkuInfo'
- rename-model:
    from: 'PagedLabServicesSkus'
    to: 'PagedSkuInfos'
```
