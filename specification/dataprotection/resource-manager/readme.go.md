## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: dataprotection
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/dataprotection/armdataprotection
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-06-preview
  - tag: package-2021-02-preview
  - tag: package-2021-01
  - tag: package-2021-07
  - tag: package-2022-03
```

### Tag: package-2022-03 and go

These settings apply only when `--tag=package-2022-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2022-03' && $(go)
output-folder: $(go-sdk-folder)/services/dataprotection/mgmt/2022-03-01/$(namespace)
```

### Tag: package-2021-07 and go

These settings apply only when `--tag=package-2021-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-07' && $(go)
output-folder: $(go-sdk-folder)/services/dataprotection/mgmt/2021-07-01/$(namespace)
```

### Tag: package-2021-01 and go

These settings apply only when `--tag=package-2021-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-01' && $(go)
output-folder: $(go-sdk-folder)/services/dataprotection/mgmt/2021-01-01/$(namespace)
```

### Tag: package-2021-02-preview and go

These settings apply only when `--tag=package-2021-02-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-02-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/dataprotection/mgmt/2021-02-01-preview/$(namespace)
```

### Tag: package-2021-06-preview and go

These settings apply only when `--tag=package-2021-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-06-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/dataprotection/mgmt/2021-06-01-preview/$(namespace)
```
