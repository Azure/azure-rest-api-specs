## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: iothub
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/deviceprovisioningservices/armdeviceprovisioningservices
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2022-02
  - tag: package-2021-10
  - tag: package-preview-2020-09
  - tag: package-2020-03
  - tag: package-2020-01
  - tag: package-2018-01
  - tag: package-2017-11
  - tag: package-preview-2017-08
```

### Tag: package-2022-02 and go

These settings apply only when `--tag=package-2022-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2022-02' && $(go)
output-folder: $(go-sdk-folder)/services/provisioningservices/mgmt/2022-02-05/$(namespace)
```

### Tag: package-2021-10 and go

These settings apply only when `--tag=package-2021-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-10' && $(go)
output-folder: $(go-sdk-folder)/services/provisioningservices/mgmt/2021-10-15/$(namespace)
```

### Tag: package-preview-2020-09 and go

These settings apply only when `--tag=package-preview-2020-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-preview-2020-09' && $(go)
output-folder: $(go-sdk-folder)/services/preview/provisioningservices/mgmt/2020-09-01-preview/$(namespace)
```

### Tag: package-2020-03 and go

These settings apply only when `--tag=package-2020-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-03' && $(go)
output-folder: $(go-sdk-folder)/services/provisioningservices/mgmt/2020-03-01/$(namespace)
```

### Tag: package-2020-01 and go

These settings apply only when `--tag=package-2020-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-01' && $(go)
output-folder: $(go-sdk-folder)/services/provisioningservices/mgmt/2020-01-01/$(namespace)
```

### Tag: package-2018-01 and go

These settings apply only when `--tag=package-2018-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-01' && $(go)
output-folder: $(go-sdk-folder)/services/provisioningservices/mgmt/2018-01-22/$(namespace)
```

### Tag: package-2017-11 and go

These settings apply only when `--tag=package-2017-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-11' && $(go)
output-folder: $(go-sdk-folder)/services/provisioningservices/mgmt/2017-11-15/$(namespace)
```

### Tag: package-preview-2017-08 and go

These settings apply only when `--tag=package-preview-2017-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-preview-2017-08' && $(go)
output-folder: $(go-sdk-folder)/services/preview/provisioningservices/mgmt/2017-08-21-preview/$(namespace)
```
