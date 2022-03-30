## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: redhatopenshift
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/redhatopenshift/armredhatopenshift
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-04-30
  - tag: package-2021-09-01-preview
```

### Tag: package-2020-04-30 and go

These settings apply only when `--tag=package-2020-04-30 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-04-30' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-04-30/$(namespace)
```

### Tag: package-2021-09-01-preview and go

These settings apply only when `--tag=package-2021-09-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-09-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/mgmt/2021-09-01-preview/$(namespace)
```
