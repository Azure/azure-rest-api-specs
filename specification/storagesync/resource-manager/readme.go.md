## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: storagesync
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/storagesync/armstoragesync
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-09-01
  - tag: package-2020-03-01
  - tag: package-2019-10-01
  - tag: package-2019-06-01
  - tag: package-2019-02-01
  - tag: package-2018-10-01
  - tag: package-2018-07-01
  - tag: package-2018-04-02
```

### Tag: package-2020-09-01 and go

These settings apply only when `--tag=package-2020-09-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-09-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-09-01/$(namespace)
```

### Tag: package-2020-03-01 and go

These settings apply only when `--tag=package-2020-03-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-03-01/$(namespace)
```

### Tag: package-2019-10-01 and go

These settings apply only when `--tag=package-2019-10-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-10-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-10-01/$(namespace)
```

### Tag: package-2019-06-01 and go

These settings apply only when `--tag=package-2019-06-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-06-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-06-01/$(namespace)
```

### Tag: package-2019-02-01 and go

These settings apply only when `--tag=package-2019-02-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-02-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-02-01/$(namespace)
```

### Tag: package-2018-10-01 and go

These settings apply only when `--tag=package-2018-10-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-10-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-10-01/$(namespace)
```

### Tag: package-2018-07-01 and go

These settings apply only when `--tag=package-2018-07-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-07-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-07-01/$(namespace)
```

### Tag: package-2018-04-02 and go

These settings apply only when `--tag=package-2018-04-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-04-02' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-04-02/$(namespace)
```
