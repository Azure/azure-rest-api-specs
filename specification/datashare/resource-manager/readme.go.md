## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: datashare
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-11-01
  - tag: package-2018-11-01-preview
```

### Tag: package-2018-11-01-preview and go

These settings apply only when `--tag=package-2018-11-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-11-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/datashare/mgmt/2018-11-01-preview/$(namespace)
```

### Tag: package-2019-11-01 and go

These settings apply only when `--tag=package-2019-11-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-11-01' && $(go)
output-folder: $(go-sdk-folder)/services/datashare/mgmt/2019-11-01/$(namespace)
```