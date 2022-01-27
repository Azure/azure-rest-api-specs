## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: siterecovery
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/recoveryservices/armrecoveryservicessiterecovery
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2022-01
  - tag: package-2021-12
  - tag: package-2021-11
  - tag: package-2021-10
  - tag: package-2021-08
  - tag: package-2021-06
  - tag: package-2021-02
  - tag: package-2018-07
  - tag: package-2018-01
  - tag: package-2016-08
```

### Tag: package-2022-01 and go

These settings apply only when `--tag=package-2022-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2022-01' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2022-01-01/$(namespace)
```

### Tag: package-2021-12 and go

These settings apply only when `--tag=package-2021-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-12' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2021-12-01/$(namespace)
```

### Tag: package-2021-11 and go

These settings apply only when `--tag=package-2021-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-11' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2021-11-01/$(namespace)
```

### Tag: package-2021-10 and go

These settings apply only when `--tag=package-2021-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-10' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2021-10-01/$(namespace)
```

### Tag: package-2021-08 and go

These settings apply only when `--tag=package-2021-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-08' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2021-08-01/$(namespace)
```

### Tag: package-2021-06 and go

These settings apply only when `--tag=package-2021-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-06' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2021-06-01/$(namespace)
```

### Tag: package-2021-02 and go

These settings apply only when `--tag=package-2021-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-02' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2021-02-10/$(namespace)
```

### Tag: package-2018-07 and go

These settings apply only when `--tag=package-2018-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-07' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2018-07-10/$(namespace)
```

### Tag: package-2018-01 and go

These settings apply only when `--tag=package-2018-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-01' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2018-01-10/$(namespace)
```

### Tag: package-2016-08 and go

These settings apply only when `--tag=package-2016-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2016-08' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2016-08-10/$(namespace)
```
