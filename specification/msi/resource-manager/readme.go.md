## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: msi
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/msi/armmsi
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-11-30
  - tag: package-2015-08-31-preview
```

### Tag: package-2018-11-30 and go

These settings apply only when `--tag=package-2018-11-30 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-11-30' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-11-30/$(namespace)
```

### Tag: package-2015-08-31-preview and go

These settings apply only when `--tag=package-2015-08-31-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-08-31-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2015-08-31-preview/$(namespace)
```