## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: storagedatalake
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-10
  - tag: package-2018-11
  - tag: package-2018-06-preview
```

### Tag:  package-2019-10 and go

These settings apply only when `--tag=package-2019-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-10' && $(go)
output-folder: $(go-sdk-folder)/services/storage/datalake/2019-10-31/$(namespace)
```

### Tag:  package-2018-11 and go

These settings apply only when `--tag=package-2018-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-11' && $(go)
output-folder: $(go-sdk-folder)/services/storage/datalake/2018-11-09/$(namespace)
```

### Tag:  package-2018-06-preview and go

These settings apply only when `--tag=package-2018-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-06-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/storage/datalake/2018-06-17/$(namespace)
```
