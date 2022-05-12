## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: account
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/datalake-store/armdatalakestore
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2016-11
  - tag: package-2015-10-preview
```

### Tag: package-2016-11 and go

These settings apply only when `--tag=package-2016-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-11' && $(go)
output-folder: $(go-sdk-folder)/services/datalake/store/mgmt/2016-11-01/$(namespace)
```

### Tag: package-2015-10-preview and go

These settings apply only when `--tag=package-2015-10-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-10-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/datalake/store/mgmt/2015-10-01-preview/$(namespace)
```

