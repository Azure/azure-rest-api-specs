## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: purview
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-07-01
  - tag: package-2020-12-01-preview
```

### Tag: package-2020-12-01-preview and go

These settings apply only when `--tag=package-2020-12-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-12-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/purview/mgmt/2020-12-01-preview/$(namespace)
```

### Tag: package-2021-07-01 and go

These settings apply only when `--tag=package-2021-07-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-07-01' && $(go)
output-folder: $(go-sdk-folder)/services/purview/mgmt/2021-07-01/$(namespace)
```
