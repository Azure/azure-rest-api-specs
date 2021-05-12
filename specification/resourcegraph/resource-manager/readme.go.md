## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: resourcegraph
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-preview-2021-03
  - tag: package-2021-03
  - tag: package-2019-04
  - tag: package-2018-09-preview
```

### Tag: package-preview-2021-03 and go

These settings apply only when `--tag=package-preview-2021-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2021-03' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-03-01-preview/$(namespace)
```

### Tag: package-2021-03 and go

These settings apply only when `--tag=package-2021-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-03-01/$(namespace)
```

### Tag: package-2019-04 and go

These settings apply only when `--tag=package-2019-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-04-01/$(namespace)
```

### Tag: package-2018-09-preview and go

These settings apply only when `--tag=package-2018-09-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-09-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-09-01/$(namespace)
```
