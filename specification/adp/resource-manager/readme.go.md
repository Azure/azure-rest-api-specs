## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: adp
  clear-output-folder: true
```
``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/adp/armadp
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-07-01-preview
  - tag: package-2021-02-01-preview
  - tag: package-2021-11-01-preview
  - tag: package-2022-03-01-preview
  - tag: package-2022-09-01-preview
```

Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

### Tag: package-2020-07-01-preview and go

These settings apply only when `--tag=package-package-2020-07-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-07-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-07-01-preview/$(namespace)
```

### Tag: package-2021-02-01-preview and go

These settings apply only when `--tag=package-2021-02-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-02-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-02-01-preview/$(namespace)
```

### Tag: package-2021-11-01-preview and go

These settings apply only when `--tag=package-2021-11-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-11-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-11-01-preview/$(namespace)
```

### Tag: package-2022-03-01-preview and go

These settings apply only when `--tag=package-2022-03-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-03-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-03-01-preview/$(namespace)
```

### Tag: package-2022-09-01-preview and go

These settings apply only when `--tag=package-2022-09-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-09-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-09-01-preview/$(namespace)
```