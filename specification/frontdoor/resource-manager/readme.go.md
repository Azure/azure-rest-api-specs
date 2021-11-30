## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: frontdoor
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/frontdoor/armfrontdoor
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-11
  - tag: package-2019-10
  - tag: package-2018-08-preview
  - tag: package-2019-04
  - tag: package-2019-05
  - tag: package-2020-01
  - tag: package-2020-04
  - tag: package-2020-05
  
```
### Tag: package-2020-05 and go

These settings apply only when `--tag=package-2020-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-05' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-05-01/$(namespace)
```

### Tag: package-2020-04 and go

These settings apply only when `--tag=package-2020-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-04-01/$(namespace)
```

### Tag: package-2020-01 and go

These settings apply only when `--tag=package-2020-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-01-01/$(namespace)
```

### Tag: package-2019-11 and go

These settings apply only when `--tag=package-2019-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-11-01/$(namespace)
```

### Tag: package-2019-10 and go

These settings apply only when `--tag=package-2019-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-10-01/$(namespace)
```

### Tag: package-2019-05 and go

These settings apply only when `--tag=package-2019-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-05' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-05-01/$(namespace)
```

### Tag: package-2019-04 and go

These settings apply only when `--tag=package-2019-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-04-01/$(namespace)
```

### Tag: package-2018-08-preview and go

These settings apply only when `--tag=package-2018-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-08-01-preview/$(namespace)
```