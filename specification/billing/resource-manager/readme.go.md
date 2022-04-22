
## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: billing
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/billing/armbilling
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api
``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-10
  - tag: package-2020-05
  - tag: package-2018-11-preview
  - tag: package-2018-03-preview
  - tag: package-2017-04-preview
```

### Tag: package-2021-10 and go

These settings apply only when `--tag=package-2021-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-10-01/$(namespace)
```

### Tag: package-2020-05 and go

These settings apply only when `--tag=package-2020-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-05' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-05-01-preview/$(namespace)
```

### Tag: package-2018-11-preview and go

These settings apply only when `--tag=package-2018-11-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-11-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-11-01-preview/$(namespace)
```

### Tag: package-2018-03-preview and go

These settings apply only when `--tag=package-2018-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-03-01-preview/$(namespace)
```

### Tag: package-2017-04-preview and go

These settings apply only when `--tag=package-2017-04-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-04-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-04-24-preview/$(namespace)
```

### Tag: package-2017-02-preview and go

These settings apply only when `--tag=package-2017-02-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-02-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-02-27-preview/$(namespace)
```