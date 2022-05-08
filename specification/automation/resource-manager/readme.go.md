## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: automation
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/automation/armautomation
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2015-10
  - tag: package-2017-05-preview
  - tag: package-2018-01-preview
  - tag: package-2018-06-preview
  - tag: package-2019-06
  - tag: package-2020-01-13-preview
```

### Tag: package-2015-10 and go

These settings apply only when `--tag=package-2015-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2015-10-31/$(namespace)
```

### Tag: package-2017-05-preview and go

These settings apply only when `--tag=package-2017-05-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-05-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-05-15-preview/$(namespace)
```

### Tag: package-2018-01-preview and go

These settings apply only when `--tag=package-2018-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-01-15-preview/$(namespace)
```

### Tag: package-2018-06-preview and go

These settings apply only when `--tag=package-2018-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-06-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-06-30-preview/$(namespace)
```

### Tag: package-2019-06 and go

These settings apply only when `--tag=package-2019-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-06-01/$(namespace)
```

### Tag: package-2020-01-13-preview and go

``` yaml $(tag) == 'package-2020-01-13-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-01-13-preview/$(namespace)
```