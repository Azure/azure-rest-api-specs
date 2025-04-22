## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: media
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/mediaservices/armmediaservices
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
 - rename-operation:
     from: OperationStatuses_Get
     to: AssetTrackOperationStatuses_Get
 - rename-operation:
     from: OperationResults_Get
     to: AssetTrackOperationResults_Get
```
