## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: appplatform
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-preview-2020-11
  - tag: package-2020-07
  - tag: package-2019-05-01-preview
```

### Tag: package-preview-2020-11 and go

These settings apply only when `--tag=package-preview-2020-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2020-11' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-11-01-preview/$(namespace)
```

### Tag: package-2020-07 and go

These settings apply only when `--tag=package-2020-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-07' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-07-01/$(namespace)
```

### Tag: package-2019-05-01-preview and go

These settings apply only when `--tag=package-2019-05-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-05-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-05-01-preview/$(namespace)
```
