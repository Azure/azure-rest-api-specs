## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: maps
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/maps/armmaps
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-02
  - tag: package-2018-05
  - tag: package-2017-01
  - tag: package-preview-2020-02
```

### Tag: package-2021-02 and go

These settings apply only when `--tag=package-2021-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-02' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-02-01/$(namespace)
```

### Tag: package-preview-2020-02 and go

These settings apply only when `--tag=package-preview-2020-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-preview-2020-02' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-02-01-preview/$(namespace)
```

### Tag: package-2018-05 and go

These settings apply only when `--tag=package-2018-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-05' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-05-01/$(namespace)
```

### Tag: package-2017-01 and go

These settings apply only when `--tag=package-2017-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-01-01/$(namespace)
```