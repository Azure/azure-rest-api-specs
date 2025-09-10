``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: updatemanager
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/updatemanager/armupdatemanager
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
```