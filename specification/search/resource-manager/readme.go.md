## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: search
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/search/armsearch
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-08
  - tag: package-2020-03
  - tag: package-2015-08
  - tag: package-2015-02
```

### Tag: package-2020-08 and go

These settings apply only when `--tag=package-2020-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-08-01/$(namespace)
```

### Tag: package-2020-03 and go

These settings apply only when `--tag=package-2020-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-03-13/$(namespace)
```

### Tag: package-2015-08 and go

These settings apply only when `--tag=package-2015-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2015-08-19/$(namespace)
```

### Tag: package-2015-02 and go

These settings apply only when `--tag=package-2015-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-02' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2015-02-28/$(namespace)
```
