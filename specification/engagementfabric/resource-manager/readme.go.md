## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)  && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: engagementfabric
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/engagementfabric/armengagementfabric
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-09-preview
```

### Tag: package-2018-09-preview and go

These settings apply only when `--tag=package-2018-09-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-09-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-09-01/$(namespace)
```
