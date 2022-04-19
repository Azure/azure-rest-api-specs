## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: kusto
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/kusto/armkusto
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2022-02
  - tag: package-2021-08-27
  - tag: package-2021-01
  - tag: package-2020-09-18
  - tag: package-2018-09-07-preview
  - tag: package-2019-01-21
  - tag: package-2019-05-15
  - tag: package-2019-09-07
  - tag: package-2019-11-09
  - tag: package-2020-02-15
  - tag: package-2020-06-14
```

### Tag: package-2022-02 and go

These settings apply only when `--tag=package-2022-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-02' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2022-02-01/$(namespace)
```

### Tag: package-2021-08-27 and go

These settings apply only when `--tag=package-2021-08-27 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-08-27' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-08-27/$(namespace)
```

### Tag: package-2021-01 and go

These settings apply only when `--tag=package-2021-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-01-01/$(namespace)
```

### Tag: package-2020-09-18 and go

These settings apply only when `--tag=package-2020-09-18 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-09-18' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-09-18/$(namespace)
```

### Tag: package-2018-09-07-preview and go

These settings apply only when `--tag=package-2018-09-07-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-09-07-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-09-07-preview/$(namespace)
```

### Tag: package-2019-01-21 and go

These settings apply only when `--tag=package-2019-01-21 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-01-21' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-01-21/$(namespace)
```

### Tag: package-2019-05-15 and go

These settings apply only when `--tag=package-2019-05-15 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-05-15' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-05-15/$(namespace)
```

### Tag: package-2019-09-07 and go

These settings apply only when `--tag=package-2019-09-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-09-07' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-09-07/$(namespace)
```

### Tag: package-2019-11-09 and go

These settings apply only when `--tag=package-2019-11-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-11-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-11-09/$(namespace)
```

### Tag: package-2020-02-15 and go

These settings apply only when `--tag=package-2020-02-15 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-02-15' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-02-15/$(namespace)
```

### Tag: package-2020-06-14 and go

These settings apply only when `--tag=package-2020-06-14 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-06-14' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-06-14/$(namespace)
```
