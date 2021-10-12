## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: communication
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-08-20
  - tag: package-2020-08-20-preview
```

### Tag: package-2020-08-20 and go

These settings apply only when `--tag=package-2020-08-20 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-08-20' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-08-20/$(namespace)
```

### Tag: package-2020-08-20-preview and go

These settings apply only when `--tag=package-2020-08-20-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-08-20-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-08-20-preview/$(namespace)
```
