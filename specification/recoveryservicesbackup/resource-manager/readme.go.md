## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: backup
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/recoveryservices/armrecoveryservicesbackup
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-07
  - tag: package-2021-01
  - tag: package-2020-12
  - tag: package-2020-02
  - tag: package-2019-06
  - tag: package-2019-05
  - tag: package-2017-07
  - tag: package-2016-12
  - tag: package-2016-06
```

### Tag: package-2021-07 and go

These settings apply only when `--tag=package-2021-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-07' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2021-07-01/$(namespace)
```

### Tag: package-2021-01 and go

These settings apply only when `--tag=package-2021-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-01' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2021-01-01/$(namespace)
```

### Tag: package-2020-12 and go

These settings apply only when `--tag=package-2020-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-12' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2020-12-01/$(namespace)
```

### Tag: package-2020-02 and go

These settings apply only when `--tag=package-2020-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-02' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2020-02-02/$(namespace)
```

### Tag: package-2019-06 and go

These settings apply only when `--tag=package-2019-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-06' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2019-06-15/$(namespace)
```

### Tag: package-2019-05 and go

These settings apply only when `--tag=package-2019-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-05' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2019-05-13/$(namespace)
```

### Tag: package-2017-07 and go

These settings apply only when `--tag=package-2017-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-07' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2017-07-01/$(namespace)
```

### Tag: package-2016-12 and go

These settings apply only when `--tag=package-2016-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2016-12' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2016-12-01/$(namespace)
```

### Tag: package-2016-06 and go

These settings apply only when `--tag=package-2016-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2016-06' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2016-06-01/$(namespace)
```
